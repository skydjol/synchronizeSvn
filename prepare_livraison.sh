echo from url: ${1} to url ${2} directory ${3}

mkdir ${3}

cd ${3}


from_revision=$(svn info  ${1} | awk '/Rev:/ { print $4 }')
to_revision=$(svn info  ${2} | awk '/Rev:/ { print $4 }')

echo ${from_revision}
echo ${to_revision}

#clone from repository
echo  CLONE from

git svn clone ${1} from_svn

echo  CLONE TO
#clone TO repository
git svn clone ${2} to_git
#
echo  CLONE TO SVN
svn checkout ${2} to_svn

cd  to_git
git fetch ../from_svn

git diff --no-prefix  master FETCH_HEAD > ../temp.patch
cd ../to_svn
patch -p0 < ../temp.patch

