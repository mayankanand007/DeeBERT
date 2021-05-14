#!/bin/bash 
export CUDA_VISIBLE_DEVICES=0 

PATH_TO_DATA=${1}

MODEL_TYPE=${2}  # bert or roberta
MODEL_SIZE=${3}  # base or large
DATASET=${4}  # SST-2, MRPC, RTE, QNLI, QQP, or MNLI

MODEL_NAME=${MODEL_TYPE}-${MODEL_SIZE}
if [ $MODEL_TYPE = 'bert' ]
then
  MODEL_NAME=${MODEL_NAME}-uncased
fi


python -um examples.run_glue \
  --model_type $MODEL_TYPE \
  --model_name_or_path ./saved_models/${MODEL_TYPE}-${MODEL_SIZE}/$DATASET/raw \
  --task_name $DATASET \
  --do_eval \
  --do_lower_case \
  --data_dir $PATH_TO_DATA/$DATASET \
  --output_dir ./saved_models/${MODEL_TYPE}-${MODEL_SIZE}/$DATASET/raw \
  --max_seq_length 128 \
  --overwrite_cache \
  --per_gpu_eval_batch_size=1
