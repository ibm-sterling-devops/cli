# Imagem base
FROM ubuntu:22.04

# 1. Update packages and install dependecies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    TZ=America/New_York \
    apt-get install -y ansible git wget && \
    apt-get clean

# Cria um diretório de trabalho
COPY home/ /app-root/

# 2. Set up Environment
ENV ANSIBLE_COLLECTIONS_PATH=/app-root/ansible_collections \
    ANSIBLE_CONFIG=/app-root/ansible.cfg \
    PATH="/app-root:${PATH}" \
    VERSION=${VERSION_LABEL:-x.y.z} \
    VIRTUAL_ENV_DISABLE_PROMPT=1

RUN umask 0002 && mkdir -p $ANSIBLE_COLLECTIONS_PATH && \
    bash /app-root/ansible_collections/ansible-install-collections.sh && \
    chmod 775 /app-root/*.sh && \
    chmod -R ug+w /app-root/functions && \
    chmod 755 /app-root/sterling  
# && \
#    chmod -R g+w $ANSIBLE_COLLECTIONS_PATH/ibm/mas_devops && \
#    ln -s $ANSIBLE_COLLECTIONS_PATH/ibm/mas_devops /mascli/ansible-devops

# Baixa o cliente OpenShift (substitua a versão conforme necessário)
RUN wget -nv https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz -O /tmp/openshift-client-linux.tar.gz && \
    tar -xzvf /tmp/openshift-client-linux.tar.gz && \
    mv oc /usr/local/bin/ && \
    rm /tmp/openshift-client-linux.tar.gz && \
    git clone https://github.com/ibm-sterling-devops/ansible-ibm-sterling


# Comando padrão ao iniciar o container (opcional)
CMD ["/app-root/sterling"]
