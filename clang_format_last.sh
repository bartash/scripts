# apply clang-foram to last commit
#
if [ -z  "${IMPALA_HOME}" ]
then
  echo impala env not set
  exit 1
fi

# see https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=65868536
git diff -U0 --no-color HEAD^ | "${IMPALA_TOOLCHAIN}/llvm-${IMPALA_LLVM_VERSION}/share/clang/clang-format-diff.py" -binary "${IMPALA_TOOLCHAIN}/llvm-${IMPALA_LLVM_VERSION}/bin/clang-format" -p1 -i

