model_name=$1
modelzoo_name=$2
echo $model_name
echo $modelzoo_name

vai_c_tensorflow \
	--frozen_pb ../models/AI-Model-Zoo/tensorflow_model/${modelzoo_name}/quantized/quantize_eval_model.pb \
	--arch arch.json \
	--output_dir compiled_output/${model_name} \
	--net_name ${model_name} \
	# --inputs_shape [1, 416, 416, 3]
	# -e '{"input_shape": "1,416,416,3"}'
	# --options {"inputs_shape": "1,224,224,3"}
	# --inputs_shape [1,416,416,3]