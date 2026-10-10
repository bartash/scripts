# apply clang-foram to last commit
#
if [ -z  "${IMPALA_HOME}" ]
then
  echo impala env not set
  exit 1
fi

# see https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=65868536
git diff asf-gerrit/master | "${IMPALA_TOOLCHAIN}/llvm-${IMPALA_LLVM_VERSION}/share/clang/clang-tidy-diff.py" -clang-tidy-binary "${IMPALA_TOOLCHAIN}/llvm-${IMPALA_LLVM_VERSION}/bin/clang-tidy" -p 1

