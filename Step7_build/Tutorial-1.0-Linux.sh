#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the Tutorial-1.0-Linux subdirectory
  --exclude-subdir  exclude the Tutorial-1.0-Linux subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Tutorial Installer Version: 1.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
This is the open source License.txt file introduced in
CMake/Tutorial/Step7...

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Tutorial will be installed in:"
    echo "  \"${toplevel}/Tutorial-1.0-Linux\""
    echo "Do you want to include the subdirectory Tutorial-1.0-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Tutorial-1.0-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +152 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the Tutorial-1.0-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� 2w\_ �\t[řI��<l+�IhPB����wBC�8Jdb��p#K׶�-�*8,�t� j����%-��申,�%�=��Rp6<۲��@�˶�R����:�D��ܙ���{�Bv���q��������j���{!y�
������r��T�y�%������]SQY]�t{*=���Y�U:�R"�b��w�r�;��k&w�|Z��?Ia��m	%z꣑�p���L��Q]Yi������J�����
�t�I'��׼�-r*ݲ3H�=�C�h��F��@$�ˊ�tŝ�ј������pD� �*_KkÕk���+�lqzN аܚ@{�Oj�����?��!�������ҽ2	��?������]��u0x��+�����P4��#;{7�o�)���_pYv>~=RG8�������*ʫ*��g#��g�鯪��U��_Y����v�����l��|�+������s��*��X}ZǋjQ��D�\�s89��Z�4_+G�+���H�Gzj�h�	��(�S�H��9^��M�S^��礸@�����m3q��O|KO�P�����ꕔ�|�R=uX���g���vE*�/ꭥr"]�������:���.�!һ����z�����Z�Y?������E=���E=���p$�_�_[]V]�G]�_�<�V�i��6�16��L���F��=��7���~����>�B%�a�2��[�z���Pz<!t�>���_�-�1�����L7�%�1��4��عӤ��&��&v.5��&��db�U�r��M�]j�K&�/@�9���M�m1�������~��?����4)�Q(w�^
�44m�R?�āyWB���\�F����H�!�H�ښ�����qE��5��D#r[ ~u�y�9׮i���}!�*L�A�
�o#0�J�	�4[��1I��J$|-�Ut���+19���&��%_k�DT�+%I�Eo����pH
ĺ�rDi^$%)5����x<�!��tG���{|�۲��BRԆ�q	t�ʆHX�^��i^��m�|�����>9�F�e��ѭU�������T�N=�Sk�`�P��5��̝/�M�ǂф�v��u  R�S�"]2.�SWl���AR{�p$$��q��d�FX�)�}��� pB��x�R@���P�$�b����:���ƾ���ұ�GЪ�z���F�k��-o�<�
���a9� W�׮r��J�,��]�7���9��WVr���%O�<���է1����fkz~7_�i
�{�>,�o��O�W�����Se���7)��=V�ty_ӷ�^k�993.�O��K�
O���������b�(������C�ЛN�W�3~d�J�=�p���6������(�O��>���8����9�\���w�z�*�pv����8�K����N~���9�/^��v���y�������8������->�����>�����9|��� ��ϱ]>�ß��sP6e��3}T4�3��{��m�[���#�5��?�\��������ES�]@��ׁ��L�RC��~��[	�[�m�������o'�]�K��j|�o��|�4~῭�	_��S�����������񅄷h|�?<Nyh��.�+����2=����-����w����F��G���O��F�~��o�y����������xs[㠽z�?X�A.&Kw�qT������0j�x��	��ޚ2u�MJ(�`^{(��8s��eL�'���-��-/��Wf������ԁN����mY� ���K_�����T�����6� �u,���}3�Yփ�N��M��/�A�fKwr�N21�o˹����yF6�m��|C�m � �����@%�_+�R�~5o+�;r�ͻ�%��8�RD&?��1�p�T�>OB��sǨ�V0�=��US��L���B�ֽ >�=9�{�ܾǰ��m���!�?��d������{�]߈�%����/�|�T�Ǧ�RĞ����"#c��i�'��������Wc�eQ���w������QM�	M$����%Zݞ�'��ۚ�B������%�V��^rs���K���H1����p���u�[���������棖D�w7O�R0�@m*p�b����/!C؉�p�}�%j=d��{�>��bl'8})���	r�P�	�{������`�v2�}t�j�S��aa�	Զ9���c�̋�.^e��Ųh�H�`�\ڶ��mӓ���E�|���Β��O�������ɦaa�@�;�>�[�}�� t��pj?���Ͽ��`b*X�Ϡ'��{601O���:�����F�<2�ߵ���4���"�o{}�?�y�}��P:i�a�"M@�i�������H��rѻs��>u\0�c77|f4`ܸ��΢F:��Fc����&�Z�n�^9
އG�펭�����F76B�'�ɬy
�{��}S�#G�_:���|^���/.%��XIi/�������&m�2T��c���|,M��,*�{�蚽��u��(�͆����k ��(4�k��8�lU}��>Oc>��.�w���Cy�(>4��rM�f���骾���,kRj��_:�I�;26A&鑋�$���L�7.V]X7q�I��*��{di�ú���{!BuW5$_�koH~R�V�<��,�	pk�c��k�O����l��7��1y�1yhE��������!��>�n}�uu�뮯��t�������7�lʦlʦl�&�ׁQ/�;��c�p4�D.�t�K��I�v�1��-;�7&1��Fg���qg�N{\&I��ƩD��rO��3	9g8V��@OBv��ho_o,u�]g�5P鐙A��:��ӟ��$�,�̶]���5ܾR��@���R�@���ãy��Tj��R����T
/��{@���>I��z-��n��O���5<���Bx�ڏ_�݅���Md�.Ʋ�c��-���̞��?dQq��a|#�V�e���W	Ç�7�:Q�XYXrEє��e��\R1�{��	u��;1���/�~ �}�J-ǀ��q��� w8���777O��-���l��|��4h��[��,i��-e!������~(g!_NG��M��WB��?��_��c�����9 �S.��H�qdE���x;�Z�Nȿ�����~<��	����n ��� �?1��|bl�8�q�e���б��PX�C���9��+,��}E���\a�@ުBo�����]WX��й��dy�cya>Y��1c�_�O�,�^�?�o��߲��V�+6�/�_YH��+�}lA�V^#��)��)��)�������_��Oa�Q���<m���^�k{�K:�˰��e{W�>�ٔg{E��?������OE1��]�]3�������lO�tʳ��<~ONlM)�����l�e�o؞��eh�/�����곽#��9H/�yJ���B�)��*�(���|�?B���M���������fJ7P�G�J�(�t�#��� ���Gݴ���ob:���:q_6��C?�t��?*��W��т���s���oY�+�W�p�ͻ�Gn���}��{�gù^��U��K������p.vU��ew���T���p%6#ܪ�C��6m_��A��vm���\m���<m>��|m���I���㓵y�ǧh�M�O�o����4���`��P��-D�O��oz|��&c������3��^�F.4����z�\����K����~��g�Xtxz��??S�F>L�8~NX�=���,����ϥ��!e�FCu��pZI�3ۡ��q��㛈|f{�0��"?�8��P���WZn5}�4Q<Eq��e�h����zM���I�o����kI/��f�Uc�y3����H�G��Krq���t-��9>��9����_[����|�ɾ�'-ؕY�߫ǧ�����#�@��fɅ�A� ���A�gU��X��O��1<ggPH�w�t���&vJ�<�:+�yVe3����\������}Џӭ����M���?Ǯ֋�WY��U���x)t��s��;M�-&�������`�q�ǳ&vvu\�㧗���hG���]'Ut\���!�����vD?_�vv���Sr���s��l��(S�k"0��s��i�6����3B�aﱯ��j��3��q����{%��ߑg��M�5�/���09�*���/��f��G��W��� J�IJ��q?q$I������H!%�K�D?
F{�zdE�j�U���p@GX
�b�M�Qb�Pg,�+K�Do�&P�8	�҉*4���'�)���}a9(���R0�+�DP�Zi���p� ��CbP�pP�_��7�()	I!Y�ü;FҪ�+��5�J�CjP�M�3Ԃ����P�ʖ�&��[�GSI�ִK>?�+Z���5uM����[H���+W�l��Imu�}RF���ˇ�Hr(���׮Y,I]����u�B��>���-5�l��W�y����
iE_[���p<Qo�b���Ze�,5$��J�
G�D\���@�m�t��>|Hh�ӎH��Gx<*u�"qp'�UtO7:+��+�v��N�a|�i%Ԟ��l�ӈ@+V�N�PF]f� A�]�ci/q^[S=�b,N�4-h0��b��K}�Ԃ#�p���VL|!p�&Q��-ɝ,Q:;�>߉��Ħ��5O�v���|-�״J��$��^��B�P��'$��k0�^.NO��( U]z4����4�
?t���3}�+Ƿ<1�Q����\hk�h&��g�1P�bJ3�e�!W|S�� 
�B���>�D����bQ(�&�H�{Be��`Д)�.D��n�
m�@*Ubj�Fu���� /&�� ���Q�0J�+J/�r���,-�X�<K]r7})���JrP�S$��F��>�U�
���j&(r��~,�|}�׫�'[6;��%����|��y,�|��/�S1_��i��z�-&��W�ߧ�T��uAFK)Ζ�D�H]�g�l���;i��d�l��w�����.�G��#R�Й>[�d�Z��*�[��&�x�n��J�oC��Dj�2}���(�N ���=T���c렌n���3��9���@翰�1,���S�g몌:����[A���2*.ӊ��}�N��מ��'E��z��6��YA��0Z ȋ��<��?�bv	������ovn�Y�o�l���~�^^,�mA��K3�@���#u��MS�z.M� �/P�E�׎b���+�Y���ڹBT���x=6�u��҅�ѓ�_b��k�C�3O����9�� �g�Q��}>y�,���/~Ub�������0DH����>��k֢���$�w]�KT�L�@q�L3��5�!^*(��f	��o���ɞ�w6����8�e���ך��r��������g#��V �|�"�>�3��:����n�op��؉�����"���.:�u<L���J7�.�Ph�'f$�˸���g��^b��K���K���#t�\�xD���#�K��K�s�����)�^��f���>s��j�*���5�q��QUO'�2��`1_63��p��K�Ap�v��t�"[�Oqk��N 4�H���ٯu���q�,��:�o�`�̾�#��YVF��;��c����5����YI�$�98�%l�}ae;:)����`2����>Ƹ���6d���;�Ĕ@��0�>�K�mqK�'�����&!������	��1�2�kM�fK���֛�'Lp�����!���ǝug����O����G�X4<�O�%��HC��=�ϔ�.ų���+���m�f�:ǿ���Դ��Xn��� �^��'_���9�E��v�����(�o���q8��L����~�/쳓ykL�6��n1n��<�>;�rs8�>N�\�'_�����Ο�8�)��,���~�������6�pv_� ��Ή>1�e~u%�[pg��$�_�g+���xX������(���	�$'V>��������Q��o�F�R�Z���x��b$��0���Z�K�~�%�b'�+�d�z���\|�^��+w,�Y��ŕ��ȸ�J�+ k'�~�(���@�+W���\\�jEƫA�ƯV�A�y�$�����2n��G\����F����<n�)(���V�v	_^p蛭���	��'�?f+w����~�+wٔMٔM_.�j? r  