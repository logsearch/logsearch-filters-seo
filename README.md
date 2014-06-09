### logsearch-filters-seo

Log parsing rules for SEO focussed logs

### Getting Started

*On Mac OX Mavericks* 
Make sure you have [java](http://www.java.com/) installed, then clone this
repository and install the dependencies it needs (it'll take a few minutes).

    $ git clone git@github.com:logsearch/logsearch-filters-seo.git
    $ cd logsearch-filters-seo
    $ git submodule init && git submodule update
    $ ./bin/install_deps.sh

When you ready to test the changes you've made to filters run the helper
scripts.

    $ ./bin/build.sh && ./bin/test.sh
    compiling src/100-googlebot.erb...done
    ..

    Finished in 0.385 seconds
    2 examples, 0 failures