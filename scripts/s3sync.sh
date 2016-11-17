#!/bin/bash
restore() {
	s3cmd sync --access_key=${AWS_S3_ACCESS_KEY} --secret_key=${AWS_S3_SECRET_KEY} s3://${AWS_S3_BUCKET_NAME}/ /data/
}

cleanup() {
	if [ "" != "${RETENTION_PERIOD_IN_DAYS}" ]
	then
		find /data -mtime +${RETENTION_PERIOD_IN_DAYS} -exec rm -f {} \;		
	fi
}

sync() {
	while [ true ]
	do
		s3cmd sync --access_key=${AWS_S3_ACCESS_KEY} --secret_key=${AWS_S3_SECRET_KEY} /data/ s3://${AWS_S3_BUCKET_NAME}/
		sleep 10
	done
}

restore
cleanup
sync