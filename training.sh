# Remove the previosly generated training data
rm -rf trainplusminus/*

# Generate training data
tesseract/tesstrain/src/training/tesstrain.py \
    --save_box_tiff \
    --langdata_dir ./langdata \
    --lang eng \
    --linedata_only \
    --fonts_dir /usr/share/fonts \
    --noextract_font_properties \
    --output_dir ./trainplusminus \
    --fontlist "Impact Condensed" \
    --tessdata_dir ./tesseract/tessdata \

# Extract the best trainned model
combine_tessdata -e ./tesseract/tessdata/best/eng.traineddata \
    ./trainplusminus/eng.lstm

# Fine tune the model
rm -rf output/*

OMP_THREAD_LIMIT=16 lstmtraining \
    --max_iterations 3600 \
    --model_output ./trainplusminus/plusminus \
    --continue_from ./trainplusminus/eng.lstm \
    --traineddata ./trainplusminus/eng/eng.traineddata \
    --train_listfile ./trainplusminus/eng.training_files.txt \
    --old_traineddata ./tesseract/tessdata/best/eng.traineddata \

# Combine the checkpoints and create the final model
lstmtraining \
    --stop_training \
	--continue_from  trainplusminus/plusminus_checkpoint \
	--traineddata trainplusminus/eng/eng.traineddata \
	--old_traineddata tesseract/tessdata/eng.traineddata \
	--model_output output/finetunedmodel.traineddata
