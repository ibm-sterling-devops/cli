#!/bin/bash

# Install IBM Pak oc addon
set -e
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
      --target-platform)
    TARGET_PLATFORM="$2"
    ;;
      --ibmpak-version)
    IBMPAK_VERSION="$2"
    ;;
        *)
        # unknown option, use as additional params directly to docker
        EXTRA_PARAMS="$EXTRA_PARAMS $key $2"
        ;;
    esac
    shift
shift
done
#fallback to amd64 if architecture not defined
if [[ "$TARGET_PLATFORM" == "" ]]
  then TARGET_PLATFORM=amd64
fi
#fallback to 1.20.0 if version not defined
if [[ "$IBMPAK_VERSION" == "" ]]
  then IBMPAK_VERSION=1.21.1
fi

curl -L https://github.com/IBM/ibm-pak/releases/download/v${IBMPAK_VERSION}/oc-ibm_pak-linux-$TARGET_PLATFORM.tar.gz -o oc-ibm_pak-linux-$TARGET_PLATFORM.tar.gz
tar -xf oc-ibm_pak-linux-$TARGET_PLATFORM.tar.gz
mv oc-ibm_pak-linux-$TARGET_PLATFORM /usr/local/bin/oc-ibm_pak
rm oc-ibm_pak-linux-$TARGET_PLATFORM.tar.gz
rm -rf /app-root/.ibm-pak

echo "oc ibm-pak version:"
oc ibm-pak --version

rm -rf /app-root/.ibm-pak