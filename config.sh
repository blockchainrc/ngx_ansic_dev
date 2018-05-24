#!/bin/sh

ngx_path=${HOME}/nginx
src_path=${HOME}/github/ngx_ansic_dev

build_date="${USER} build at `date '+%Y.%m.%d %H:%M'`"
cc_opt="-g -O0"

prefix="--prefix=/opt/nginx"
common_opts="--with-threads --with-pcre-jit"

modules=""

no_modules="--without-http_fastcgi_module \
            --without-http_uwsgi_module \
            --without-http_scgi_module
           "

http_modules=""

for m in $modules
do
    http_modules="${http_modules} --add-module=${src_path}/http/${m} "
done

modules=""

stream_modules="--with-stream "

for m in $modules
do
    stream_modules="${stream_modules} --add-module=${src_path}/stream/${m} "
done

opts="${prefix}           \
      ${common_opts}      \
      ${http_modules}     \
      ${stream_modules}   \
      ${no_modules}
      "

cd $ngx_path

./configure     \
    --build="${build_date}" \
    --with-cc-opt="${cc_opt}"  \
    ${opts}


cd -
