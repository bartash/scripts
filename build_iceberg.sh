#
export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64

# How to set number fo workers
./gradlew build -x test -x integrationTest --max-workers=4
