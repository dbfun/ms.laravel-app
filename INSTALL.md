* пересобираем образ: `make rebuild`
* после этого приложение будет выдавать 500 ошибку, так как монтируется dev-образ, в котором нет `vendor`, `.env`
* поэтому входим `make workspace` и выполняем `cd laravel-app && ./install.sh` - это установит зависимости, и они будут видны в вашем любимом редакторе