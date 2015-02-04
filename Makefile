PAPER=display
#RESOLUTION=1200
RESOLUTION=600
IMAGE_RESOLUTION=300
DVIPS=dvips -j0 -Ppdf -Pdownload35 -G0 -t letter -D ${RESOLUTION} -Z -mode ljfzzz


all: paper

paper: 
	latex ${PAPER}.tex
	bibtex ${PAPER}
	latex ${PAPER}.tex
	latex ${PAPER}.tex
	${DVIPS} ${PAPER}.dvi -o - | gs -q -dNOPAUSE -dBATCH \
               -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress\
               -dCompatibilityLevel=1.4 \
               -dCompressPages=true -dUseFlateCompression=false \
               -sPAPERSIZE=letter \
               -dSubsetFonts=true -dEmbedAllFonts=true \
               -dProcessColorModel=/DeviceGray \
               -dDetectBlends=true -dOptimize=true \
               -dDownsampleColorImages=true -dColorImageResolution=${IMAGE_RESOLUTION} \
               -dColorImageDownsampleType=/Average -dColorImageFilter=/FlateEncode \
               -dAutoFilterColorImages=false -dAntiAliasColorImages=false \
               -dColorImageDownsampleThreshold=1.50000 \
               -dDownsampleGrayImages=true -dGrayImageResolution=${IMAGE_RESOLUTION} \
               -dGrayImageDownsampleType=/Average -dGrayImageFilter=/FlateEncode \
               -dAutoFilterGrayImages=false -dAntiAliasGrayImages=false \
               -dGrayImageDownsampleThreshold=1.50000 \
               -dDownsampleMonoImages=true -dMonoImageResolution=${RESOLUTION} \
               -dMonoImageDownsampleType=/Average -dMonoImageFilter=/FlateEncode \
               -dAutoFilterMonoImages=false -dAntiAliasMonoImages=false \
               -dMonoImageDownsampleThreshold=1.50000 \
               -sOutputFile=${PAPER}.pdf \
               -c save pop -
	#dvips -Pcmz -t letter -D 600 -G0 -o ${PAPER}.ps ${PAPER}.dvi
	#ps2pdf14 -dEmbedAllFonts=true ${PAPER}.ps
	#rm ${PAPER}.ps

clean:
	rm -f *.dvi *.aux *.log *.bbl *.blg

