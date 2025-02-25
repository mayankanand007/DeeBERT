#!/bin/bash
export CUDA_VISIBLE_DEVICES=0

PATH_TO_DATA=${1}

MODEL_TYPE=${2}  # bert or roberta
MODEL_SIZE=${3}  # base or large
DATASET=${4}  # SST-2, MRPC, RTE, QNLI, QQP, or MNLI

MODEL_NAME=${MODEL_TYPE}-${MODEL_SIZE}
EPOCHS=10
if [ $MODEL_TYPE = 'bert' ]
then
  EPOCHS=3
  MODEL_NAME=${MODEL_NAME}-uncased
fi


python -um examples.run_highway_glue \
  --model_type $MODEL_TYPE \
  --model_name_or_path $MODEL_NAME \
  --task_name $DATASET \
  --do_train \
  --do_eval \
  --do_lower_case \
  --data_dir $PATH_TO_DATA/$DATASET \
  --max_seq_length 128 \
  --per_gpu_eval_batch_size=1 \
  --per_gpu_train_batch_size=8 \
  --learning_rate 2e-5 \
  --num_train_epochs $EPOCHS \
  --overwrite_output_dir \
  --seed 42 \
  --output_dir ./saved_models/${MODEL_TYPE}-${MODEL_SIZE}/$DATASET/two_stage \
  --plot_data_dir ./plotting/ \
  --save_steps 0 \
  --overwrite_cache \
  --eval_after_first_stage
