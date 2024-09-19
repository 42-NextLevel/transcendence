if [ ! -f srcs/confidential/.env ]; then
	git submodule init
	git submodule update
fi