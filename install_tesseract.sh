# Install training dependencies and font type
sudo apt update
sudo apt install ttf-mscorefonts-installer
sudo apt install fonts-dejavu
fc-cache -vf

# Create output folder
mkdir output

# Install langdata_lstm and langdata components
mkdir langdata
cd langdata
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/main/radical-stroke.txt
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/main/common.punc
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/main/font_properties
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/main/Latin.unicharset
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/main/Latin.xheights
mkdir eng
cd eng
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/main/eng/eng.training_text
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/main/eng/eng.punc
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/main/eng/eng.numbers
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/main/eng/eng.wordlist

# Clone tesseract repo
cd ~/tesseract-fine-tuning
git clone --depth 1 https://github.com/tesseract-ocr/tesseract.git

# Download tesstrain
cd tesseract/
git clone https://github.com/tesseract-ocr/tesstrain.git

# Download tessdata
cd tessdata/
wget https://github.com/tesseract-ocr/tessdata/raw/main/eng.traineddata

# Download best tessdata
mkdir best
cd best
wget https://github.com/tesseract-ocr/tessdata_best/raw/main/eng.traineddata

#Install tqdm Libary
sudo apt install python3-pip
pip3 install tqdm
