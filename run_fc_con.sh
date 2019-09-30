#! /bin/sh

id="fc_con"
ckpt_path="log_"$id
if [ ! -d $ckpt_path ]; then
  mkdir $ckpt_path
fi
if [ ! -f $ckpt_path"/infos_"$id".pkl" ]; then
start_from=""
else
start_from="--start_from "$ckpt_path
fi

python train.py --id $id --caption_model fc --vse_model fc --share_embed 0 --input_json data/flickrtalk.json \
                --input_label_h5 data/flickrtalk_label.h5 --input_fc_dir /data1/fankaixuan/features/Flickr30k \
                --input_att_dir /data1/fankaixuan/features/Flickr30k --batch_size 128 --beam_size 1 \
                --learning_rate 5e-4 --learning_rate_decay_start 0 --learning_rate_decay_every 15 \
                --scheduled_sampling_start 0 --checkpoint_path $ckpt_path $start_from --save_checkpoint_every 300 \
                --language_eval 1 --val_images_use 1014 --max_epochs 28 --vse_loss_weight 1 --caption_loss_weight 0 --rank_eval 1


