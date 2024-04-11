# copied and mutated from swagger.Dockerfile
export GO_VERSION=1.21.1
export TARGET_OS=linux
export TARGET_ARCH=amd64
export SWAGGER_GO_VERSION=0.28.0
export SWAGGER_CODEGEN_VERSION=2.2.1
export SWAGGER_CODEGEN_JAR=/usr/local/share/swagger-codegen.jar


cd /tmp && \
    curl -sSL -O https://dl.google.com/go/go${GO_VERSION}.${TARGET_OS}-${TARGET_ARCH}.tar.gz && \
    tar -xf go${GO_VERSION}.${TARGET_OS}-${TARGET_ARCH}.tar.gz && \
    rm go${GO_VERSION}.${TARGET_OS}-${TARGET_ARCH}.tar.gz && \
    mv go /usr/local

curl -sSL \
    -o ${SWAGGER_CODEGEN_JAR} \
    https://oss.sonatype.org/content/repositories/releases/io/swagger/swagger-codegen-cli/${SWAGGER_CODEGEN_VERSION}/swagger-codegen-cli-${SWAGGER_CODEGEN_VERSION}.jar

curl -sSL \
    -o /usr/bin/swagger \
    https://github.com/go-swagger/go-swagger/releases/download/v${SWAGGER_GO_VERSION}/swagger_linux_amd64 \
    && chmod +x /usr/bin/swagger
