if [ ! -f srcs/confidential/.env ]; then
	git submodule update --init --recursive --remote
# else
# 	git submodule update --remote --merge
fi