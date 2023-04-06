RED="\033[0;31m"
BLUE="\033[0;34m"
ORANGE="\033[0;33m"
YELLOW="\033[1;33m"
LGREEN="\033[1;32m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
BOLD="\033[1m"
NC="\033[00m"

function switchCluster ()
{
    clear

    SHARED_CLUSTER_NAMES=()
    SHARED_CLUSTER_TYPES=()
    SHARED_CLUSTER_CLASS=("DEV" "QE")

    SHARED_CLUSTER_NAMES+=("shared-rke")
    SHARED_CLUSTER_TYPES+=("RKE")

    SHARED_CLUSTER_NAMES+=("shared-os")
    SHARED_CLUSTER_TYPES+=("OCP")

    FINAL_CLUSTERS=()
    FINAL_CLUSTER_TYPES=()

    echo -e "${ORANGE}${BOLD}Available clusters:${NC}\n"
    for i in "${!SHARED_CLUSTER_NAMES[@]}"
    do
        for j in "${!SHARED_CLUSTER_CLASS[@]}"
        do
            THIS_CLUSTER_CLASS_UPPER=$(echo ${SHARED_CLUSTER_CLASS[j]} | awk '{print toupper($0)}')
            THIS_CLUSTER_CLASS_LOWER=$(echo ${SHARED_CLUSTER_CLASS[j]} | awk '{print tolower($0)}')
            if [ "${THIS_CLUSTER_CLASS_UPPER}" = "DEV" ]
            then
                THIS_CLUSTER_CLASS_UPPER="${CYAN}${BOLD}${THIS_CLUSTER_CLASS_UPPER}${NC}"
            else
                THIS_CLUSTER_CLASS_UPPER="${LGREEN}${BOLD}${THIS_CLUSTER_CLASS_UPPER}${NC}"
            fi

            NUM_OF_CLUSTERS_IN_CLASS=5
            for k in $(seq 1 ${NUM_OF_CLUSTERS_IN_CLASS})
            do
                THIS_CLUSTER_SUFFIX="${k}"
                if (( (THIS_CLUSTER_SUFFIX / 10) == 0 ))
                then
                    THIS_CLUSTER_SUFFIX="0${THIS_CLUSTER_SUFFIX}"
                fi
                THIS_CLUSTER_NAME="${SHARED_CLUSTER_NAMES[i]}-${THIS_CLUSTER_CLASS_LOWER}-${THIS_CLUSTER_SUFFIX}"
                NUM_OF_CLUSTER_CLASS="${#SHARED_CLUSTER_CLASS[@]}"
                NUM_OF_CLUSTERS_IN_NAME=$(( NUM_OF_CLUSTERS_IN_CLASS * NUM_OF_CLUSTER_CLASS ))
                THIS_CLUSTER_INDEX=$(( (i * NUM_OF_CLUSTERS_IN_NAME) + k + (NUM_OF_CLUSTERS_IN_CLASS * j) ))
                THIS_CLUSTER_INDEX_STR="${THIS_CLUSTER_INDEX}"
                if (( (THIS_CLUSTER_INDEX / 10) == 0 ))
                then
                    THIS_CLUSTER_INDEX_STR="0${THIS_CLUSTER_INDEX_STR}"
                fi
                if (( (THIS_CLUSTER_INDEX % 2) == 0 ))
                then
                    THIS_CLUSTER_SUFFIX="${PURPLE}${BOLD}${THIS_CLUSTER_SUFFIX}${NC}"
                    THIS_CLUSTER_INDEX_STR="${PURPLE}${BOLD}${THIS_CLUSTER_INDEX_STR}${NC}"
                else
                    THIS_CLUSTER_SUFFIX="${YELLOW}${BOLD}${THIS_CLUSTER_SUFFIX}${NC}"
                    THIS_CLUSTER_INDEX_STR="${YELLOW}${BOLD}${THIS_CLUSTER_INDEX_STR}${NC}"
                fi
                if [ "${SHARED_CLUSTER_TYPES[i]}" = "OCP" ]
                then
                    THIS_CLUSTER_DESC="Shared ${RED}${BOLD}${SHARED_CLUSTER_TYPES[i]}${NC} Cluster - ${THIS_CLUSTER_CLASS_UPPER} ${THIS_CLUSTER_SUFFIX}"
                else
                    THIS_CLUSTER_DESC="Shared ${BLUE}${BOLD}${SHARED_CLUSTER_TYPES[i]}${NC} Cluster - ${THIS_CLUSTER_CLASS_UPPER} ${THIS_CLUSTER_SUFFIX}"
                fi
                echo -e "${THIS_CLUSTER_INDEX_STR}. ${THIS_CLUSTER_DESC} (${BOLD}${THIS_CLUSTER_NAME}${NC})"
                FINAL_CLUSTERS+=("${THIS_CLUSTER_NAME}")
                THIS_CLUSTER_TYPE_LOWER=$(echo ${SHARED_CLUSTER_TYPES[i]} | awk '{print tolower($0)}')
                FINAL_CLUSTER_TYPES+=("${THIS_CLUSTER_TYPE_LOWER}")
            done
            echo -e ""
        done
    done

    SELECTED_CLUSTER_INDEX=0
    FINAL_NUM_OF_CLUSTERS="${#FINAL_CLUSTERS[@]}"
    read -p "Select a cluster index [1 - ${FINAL_NUM_OF_CLUSTERS}] from the list: " SELECTED_CLUSTER_INDEX
    if ! [[ ${SELECTED_CLUSTER_INDEX} =~ ^[0]*[1-9][0-9]*$ ]]
    then
        echo -e "${RED}Error: ${SELECTED_CLUSTER_INDEX} is not a positive integer${NC}\n"
        return
    fi
    if (( SELECTED_CLUSTER_INDEX < 1 || SELECTED_CLUSTER_INDEX > FINAL_NUM_OF_CLUSTERS ))
    then
        echo -e "${RED}Error: ${SELECTED_CLUSTER_INDEX} is not in range${NC}\n"
        return
    fi

    SELECTED_CLUSTER_INDEX=$(( SELECTED_CLUSTER_INDEX - 1 ))
    FINAL_CLUSTER_DIR="${HOME}/kube/${FINAL_CLUSTER_TYPES[SELECTED_CLUSTER_INDEX]}"
    FINAL_CLUSTER_FILE="${FINAL_CLUSTER_DIR}/${FINAL_CLUSTERS[SELECTED_CLUSTER_INDEX]}.yaml"
    mkdir -p "${FINAL_CLUSTER_DIR}"

    curl "http://kubeconfig-01.kcloud.cloudera.com:8080/${FINAL_CLUSTERS[SELECTED_CLUSTER_INDEX]}/kubeconfig" > "${FINAL_CLUSTER_FILE}" 2> /dev/null

    export KUBECONFIG="${FINAL_CLUSTER_FILE}"
    echo -e "${ORANGE}${BOLD}Using cluster ${FINAL_CLUSTERS[SELECTED_CLUSTER_INDEX]}${NC}\n"
}
