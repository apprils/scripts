
find lib \
  -type f \
  -not -name "_*" \
  -execdir bash -e -c "
    cd $PWD
    outfile=pkg/\${0%.*}
    cp lib/_util.sh \$outfile
    cat lib/\$0 >> \$outfile
    chmod +x \$outfile
  " {} \;

