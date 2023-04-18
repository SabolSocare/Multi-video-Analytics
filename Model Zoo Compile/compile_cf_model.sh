model_name=$1
modelzoo_name=$2
vai_c_caffe \
	--prototxt ../models/AI-Model-Zoo/caffe_model/${modelzoo_name}/quantized/deploy.prototxt \
	--caffemodel ../models/AI-Model-Zoo/caffe_model/${modelzoo_name}/quantized/deploy.caffemodel \
	--arch ./arch.json \
	--output_dir ./compiled_output/${modelzoo_name} \
	--net_name ${model_name} \
	--options "{'mode': 'normal'}"
