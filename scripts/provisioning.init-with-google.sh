#!/usr/bin/zsh

# Todo: args for envs
declare ENV_NAME_CURRENT="development"
# Todo: check PROJECT_UNIQUE_ID
# Todo: check TF_DATA_DIR
export BUCKET_NAME_FOR_PROVISIONING="${PROJECT_UNIQUE_ID}-${ENV_NAME_CURRENT}-provisioning"
export GOOGLE_APPLICATION_CREDENTIALS="/project/config/${ENV_NAME_CURRENT}/credentials/google-cloud-keyfile.json"

# Auth gcloud
gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}
gcloud auth configure-docker gcr.io --quiet

# Create the GCS bucket to save tfstate

gsutil ls gs://${BUCKET_NAME_FOR_PROVISIONING}/ > /dev/null 2>&1 || {
  gsutil mb -b on gs://${BUCKET_NAME_FOR_PROVISIONING}/
}
# for exist buckets
gsutil uniformbucketlevelaccess set on gs://${BUCKET_NAME_FOR_PROVISIONING}/
gsutil versioning set on gs://${BUCKET_NAME_FOR_PROVISIONING}/

# Init terraform
sudo chmod a+rwx ${TF_DATA_DIR}
terraform init -backend-config="bucket=${BUCKET_NAME_FOR_PROVISIONING}"