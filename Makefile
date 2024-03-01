all: fft.exe fib.exe loop.exe quicksort.exe soli.exe takc.exe taku.exe
	@moon build > /dev/null
	@echo fib: ocamlopt vs moonbit vs ocamlc
	@time -f %U ./fib.exe
	@time -f %U moon run fib
	@time -f %U ./fib.bc
	@echo loop: ocamlopt vs moonbit vs ocamlc
	@time -f %U ./loop.exe
	@time -f %U moon run loop
	@time -f %U ./loop.bc
	@echo quicksort: ocamlopt vs moonbit vs ocamlc
	@time -f %U ./quicksort.exe
	@time -f %U moon run quicksort
	@time -f %U ./quicksort.bc
	@echo soli: ocamlopt vs moonbit vs ocamlc
	@time -f %U ./soli.exe
	@time -f %U moon run soli
	@time -f %U ./soli.bc
	@echo takc: ocamlopt vs moonbit vs ocamlc
	@time -f %U ./takc.exe
	@time -f %U moon run takc
	@time -f %U ./takc.bc
	@echo taku: ocamlopt vs moonbit vs ocamlc
	@time -f %U ./taku.exe
	@time -f %U moon run taku
	@time -f %U ./taku.bc

fft.exe: fft.ml
	@ocamlopt fft.ml -o fft.exe
	@ocamlc   fft.ml -o fft.bc

fib.exe: fib.ml
	@ocamlopt fib.ml -o fib.exe
	@ocamlc   fib.ml -o fib.bc

loop.exe: loop.ml
	@ocamlopt loop.ml -o loop.exe
	@ocamlc   loop.ml -o loop.bc

quicksort.exe: quicksort.ml
	@ocamlopt quicksort.ml -o quicksort.exe
	@ocamlc   quicksort.ml -o quicksort.bc

soli.exe: soli.ml
	@ocamlopt soli.ml -o soli.exe
	@ocamlc   soli.ml -o soli.bc

takc.exe: takc.ml
	@ocamlopt takc.ml -o takc.exe
	@ocamlc   takc.ml -o takc.bc

taku.exe: taku.ml
	@ocamlopt taku.ml -o taku.exe
	@ocamlc   taku.ml -o taku.bc
