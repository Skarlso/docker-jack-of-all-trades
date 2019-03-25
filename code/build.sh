docker build -t skarlso/idlerpg:debug \
    --build-arg api_key=${MG_API_KEY} \
    --build-arg domain=${MG_DOMAIN}