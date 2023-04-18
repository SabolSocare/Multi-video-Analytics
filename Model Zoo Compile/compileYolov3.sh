model_name=$1
modelzoo_name=$2
vai_c_tensorflow --frozen_pb ../models/AI-Model-Zoo/tensorflow_model/${modelzoo_name}/quantized/quantize_eval_model.pb \
	--arch ./arch.json \
	--output_dir ./compiled_output/${model_name} \
	--net_name ${model_name} \
	--options "{'mode':'normal','save_kernel':'', 'input_shape':'1,416,416,3'}"
	
