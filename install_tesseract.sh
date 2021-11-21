# Install training dependencies and font type
sudo apt update
sudo apt install ttf-mscorefonts-installer
sudo apt install fonts-dejavu
fc-cache -vf

# Update the machine
sudo apt-get update

# Install training dependencies
sudo apt-get install libicu-dev libpango1.0-dev libcairo2-dev -y
sudo apt install libtesseract-dev -y
sudo apt-get install libleptonica-dev -y

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

# Clone tesseract repo and tesseract
cd ~/tesseract-fine-tuning
git clone --depth 1 https://github.com/tesseract-ocr/tesseract.git
sudo apt install tesseract-ocr

# Install tesseract
cd tesseract/
./autogen.sh
./configure
make
sudo make install
sudo ldconfig
make training
sudo make training-install

# Add path to .bashrc
echo  'export TESSDATA_PREFIX=/usr/local/share/tessdata' >> ~/.bashrc
source ~/.bashrc

# Testing tesseract installation
echo `tesseract --version | grep 'tesseract'`


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
