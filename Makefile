SRC=src
boot:	$(SRC)/boot.s
	nasm $(SRC)/boot.s -o $(SRC)/boot.img -l $(SRC)/boot.lst
