FROM openapitools/openapi-generator-cli

ARG TMP_VOL="/local"
ARG INPUT="bmon-odds.yaml"
ARG CONFIG="config.yaml"
ARG IGNORE_FILE=".openapi-generator-ignore"
ARG LANG="spring"
ARG OUT_DIR="out/spring"

WORKDIR "${TMP_VOL}"

CMD ["generate", "-i ${INPUT}", "-c ${CONFIG}", "--ignore-file-override ${IGNORE_FILE}", "-g ${LANG}", "-o ${OUT_DIR}"]