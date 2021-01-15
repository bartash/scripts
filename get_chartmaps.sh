#
# download those mapping files
#
# OK = prod, priv

for STAGE in dev priv prod
do
	echo $STAGE
	aws s3 cp s3://cdw-${STAGE}-vmaps/availableversions/hive hive.mow-${STAGE}
	aws s3 cp s3://cdw-${STAGE}-vmaps/availableversions/impala impala.mow-${STAGE}
	aws s3 cp s3://cdw-${STAGE}-vmaps/dwx2cdhmaps/1.1.2_Map 1.1.2_Map.mow-${STAGE}
done

