if [ ! -f srcs/confidential/.env ]; then
	git submodule update --init --recursive --remote
fi