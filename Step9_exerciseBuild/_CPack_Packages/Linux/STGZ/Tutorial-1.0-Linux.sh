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
� ��]_ �]|Tՙ?������`��+�L���LH0����d�&Mf��V,�b]Ә����,�-����v�Z[kC���օ�m�u��n�X�������{Νs�ܛ�Fֶ������}�|��s_��o$�L��%�$��SUU���\#����������S��x˽���U�A�(�P�q妘�vu��MTN���?���ߜTb�H��&m���;&����r��_��jǿ�[ǿ����3�A��_��_�ĥtȮ9�ɸvź�H,�p�aWBV�H�=�j��]l�L�XXn�DeM!m�76�^�A��^wu��;�A�0�h-M~�����������+%v����5�h���=�'<�=�e���V�UT���S���A�`����dW̀66\���%[;eW▸2���Yp�ԝ֙��D����������J˫��A������>��ǿ���<}�ˡ���x*�����O����m6Mv�O",m���>�?�*��CKQ>��B��l����ȇ�z�����;TY�Azn�s�����sT����d����sޏ��z��z���^��ß�s�����٩�(����{�z��uҿ��^���~����W#=g�6�F	��������6�笽����Ν��m����=g�lIg���|Ig��3M���,�,�,w'b�R-.��Sk7���6�ul��3���c����{��f4�����ߞ��QD��\?���(=��<�=����隵'��l~�0�،�_E���M�1����M�?1��:�}&�<`R�ͤ��&�י��4��٤��z�@�s���M��eR��M�g���k���~�I��A���7�~:��|>U.b'�O�w�DIR{W,*�;�"IH�m���r\n�$9�\_����Ax�PˌK���-ӽ���w7�P¡E��i[��b�	(`�"�W�6�_��o�I)�����P�����>.)�`DI���te��D$$�J\v�6K���T)��rIR:��R$�-�	K�x{�K�*�C�%�J�B==^��T��Dۍ�#Q�k�~�m\�T&�,�����шB�V;Ӱ��)�$����H�r<�B�i�G�huY��T:N���s�P3�P����,��&}�B��� ; ��bmR<m�q�0�CP'�^$�D�G�a�QN����!:C�T�,�:n�ڂ�NA(1�/ZP
*rOZ��x<�:c� �n��-��V����N�`$����Hen�ټ�zU��u���u��@u9��]�UE����R�d�	�������N~9��Oل���vĞ��l��n���+�5||�4l�.�Y٠������������Puʂ/���
�|��}v|����w��~{��=3��wׅ�>9;2�_N����=W�.R�IA��Y*�����z&�T9��{-�c����sz�9e����ѓ�~���s�QN_���8������_~�8=�.��9�~)�'����=��K��o��Y�~3����[9}.����S8}7��W�z8�4N����q��8}>����~�/���9�tN��_��q����0��Ydх�?�};��jn�?�WK��̐bO��(�()OU�A}:u�X�eĞ|8���Tj��6"��d;��h�����d'����YD��&gy�&��M�%rP��y�&O%r�&O#�W��<O��<]��l��B"�:��"��L��I���V��_�����
���}A�� �� ? ��(��
� F�w
rR��Y�-����ھ7�^���hCs�@֝p�����8��٬Fpy}��%X�u+f�ƔY05�%�Ԝ�:Yx�.<��R��}�:�����ae�Ș#`{2p�2*Ȣ�N����?�o�
?>�\��]�^(��F����-#��q	�dx2�`g��:���C!��~Mp6u����K���+���#ޡޝ�l��<��~�`��OB���FfB#Љ�y����,�!U�Q�dZ��(C��\��C��ۋ���#�<C*���\������/�vӊ�Mֿ����a�˿$��?��#u���#70�r��}��ҿ%����(���@��`�?�>5bS�H}gH}��(:4�3?�F:2Q���.�j�cT۫�i���1��f�����Z���ac�H8P�G����2rY�;�B���䤕$�ݤ�a���S�{�q���l2�\(���n_r�w绶d��c�̴Л���`��Y�/$Sx{�օj?F߁��Ze�c��C1�&���@��1�r���1�{�;lF}G��⩤��Z�֍ױ�Ψad���J��F< <E��`��tl�>3���ƭ������+�">]8�?F8,9?��0D{(��r �W�_8Q`���ܒ£�r�9 �\~��	67���x`��@2���m8��Ƒ��]�� �0�TP�CJ�̯d��@�<_�ӅE�a��@�����,���P���I�I0��â|��,�,R{�\����!��=�M���0��&\�����������J��7�����������w[%�n�[p߳GV�l
9�P.�>G�Gu}�������wթ��z���~��=��_�����-�7VKG���|{G�� ��o�EYd�E��^wE	����$��Xԅܨ%l����+��j�㨹oK�+�)�X�E.��
�ů�'_K��JO�R�����w�N�� ��Gx\�����H�ƀ��C���q���|��7�>����Tj)��
|]�dkh�[����6'/'�b=�;�b �V�eP�ݭ��C�.�$XP���x]���������]q9���h*ů�b=^�.�zn��u7�u��J�����;�5��;  ��c����D�s��s��⽂��(ě}s������:)���:���v����ۙ	��㔗C�(�ɗ�W�q߀��P>�?C�8��q܆�%�z��j�|��@��|y���O�����q����{�şs�\N����Vx��,��Y[��,�.�T�_U�ZUP���hUA.Y���d�B=�zs*e��_���Y/9�>{�3�o�Gl�h��_��;�a�EYd�EYdџ3�� l����#�"ȷ����T��З�w �n�`{0���9zsm/	ۏ���އ7Φb�率K�j�T�����l�Tf{�~o	&�g�E��={hG��ۣ��"��������n��l�k.�۽�R�g���T�O�KQ��9J�Wi�oQy�=��IlߵHz@}�7P���n�wQ>H�~�Q>D�q�OR>�&�TRD��r��d��{b���f�k~Kk2�$]��enO�ד$b�U1a�8��#�]�'��;�}�z��f�����>[;?���<��s����O��^?U��z�4�<������4}>r�����:P!j0�i�z�t�����0��뀋��P?�g�a�M�t�v���/Ѯ{z}��y怫)�N����	&:}z߱^�����q*%����x
�Y@�C�~��6yU�6栆�t{�֐ߙ��E��	�� ����$����t����l��w��&z����ճ�'�����E6\6=k0��� 2�ەٸ���ԟ9OV�z.��T/�[�ԓ9����s��Q�|+���/9�)�9���౐n�\D����<}ޱ��Yjv��~�ɾ��&��H�E��Ο|zc̤�/w�}v�u��$?�D�Y�σz�~Sv������σ&�|�D�;��/v}cɪϚ�_�4�W��7�軜����}��8�aФ�����I-�Ws��j��Nu>���ÞǂY���m�0K�_��[Yj��������4�gN�:���AP��E���u&�P�q~ɧM��3����0���l�_:ns�.���j�1�?�c�n�=&���1�d�׃Bq%�$���!�N���.)�S]H��1��3���J,�����uuwʊv/�T,36©	)�wHrT��@m�`�,��]];���$�Tt�
�v�zzH�E�wYwD��#	Y
Ţ	%���uK%)�U�X�%�J$D*����/!�a),�~X�D"HZ[w���:pI�J�jڄ$�i���K��qr��vC��Pe`u#�V_������tq��
����p��5M�f��zU�_�H�����I� t��$�=��)*��_�`m8Z����=RÚf�a}�Wjhh*�Vw7�J8mg�t5-���^�)�MV�RWj��Z��L��Inar|�8��R�I.�0��)]3x�&bR���5AF���^s�2z��w\nsfQ��@B���qyyR��ӻ2KY��8��\�th������W,�jƓKW3�@�\b'�����'w��UJM���VU$���q���KS0�Զֵz����2�n�Q(I����n���'t��Mҹ����,#N<�$�,�HJ��`f�|\r���(�3^z�.%�h��6h��`��qD'�
X���b"�x��OYv�����N�]��%Bf�x�#B�Ď.%�
�F�w�_x�ǻ�;Sd7D���`�(;8Uk2�.���
&M�lG��#��@���(4�r%��lS7��	��rg�_ݝ
�f)��n��	9��p���w<Fn�n��>t��i	�	�$�'$w+�B�۝���u���x�+ի�	���X��F�Y�Ix�?J�uR3�
F6A���Ι�$0��J�_�g�B��Ek��v�I���5��f*c�l����Tϖ����H]�f�l]������2��AzL�~���:�8�� uM���u>Ɨ
��~;Rר���D��(��8������g�������G��{[_d|�������2pO�P�2��>���Wj\p^���ɸ��)����'�E������@�$�����g0�/؋���_?D`qyS����o��b������q/����������2�@�Ͽ?!u픝��
�c�;W���o���:��b�xE�B�>W[�ӡ��������N�$~7sх���_l��k�@��</�g.�P��ٺS1�ܧ��h����/�?���
SDm���u�+C�ן)\�<ݵL����g������b�A��h|�G�'�_���w!#h�ɤ��_˽�O��W�߅ 3�?���G��J�`��i��\��	��:r��\���8��\���a�s��X�*[��E�{���w���\!p����z��S�b���1j'rv��������η=���MDn���~��̎�R����x�x{g����o/�q]���zg~����1����{��ݍ?�;�?��g�O�xr�g{�=��W�����{1��e�/7����L�I����b{���;2~�3�Zt�I<�m�n��Gie�>F��I�	z��@�-F�|���U49qD��oFIeXV���ʮ�3�ȣ��7D���8'¾���Lq֌�xx34/�f�������(�u�Nvz��U�1;�Ç��˖��*��}��\~�-}�P����!Zή�:v�Χ�~/�1,軩�V�^�d��������s���_ux�/~����o1���-f<��Kž��x^.NϿW���<����������qz��"�,��"�,�����Mc��U���.���_"��	�,�[�E��Y�?0����7��%i��G����}��W�]2��N��xs8\�7w��cxsπ0�Vo�bɄxs���la�.�j*�a{y��p[�kCm�K���)����S���������_RV�*����Ͽ�' bKT�/i�s�h�j{�j8Z��C�pQ�g�r'-=���w�S
��!�������q�O��hH�m��.����#������Ub|-ho$���fb3
�6���񾦁�k�p���q��WM~���j&=v�㋵n~���Wm/�����>}N�oa��J�����D ����(�������"�,��"�,��"���$d�?�&��]J��!wv��"Ѱ+u�.׶`gRv��XWw�����VE�V(R�}��·�0=J�+1^ ����z-�ڊT����{��^{J�徉���t*5|�S)�����{�Pw76��1�Z&�������׉���A��[&óۜ���;��,��o���q���㾜2��{���6�˳�"�,��"�,��"�,b�����nl��u�M/�?�^��R���aZ/Áb�����~;3|�Q������O7�iy���#4>�P̫b{�X^���p�^8['�k�^a�gx��]�W���_h���%��]���74#����ht�����������~���G�a鑾�ޕ����l�5��T~n��w���޺}a��ɲ��/�Ϧ��Ѭ&����Ho�����m^��Nm>��Yڼ�복����h�N����^?E��z�T<�i&x�y~�^���Y�����1~���L��kyz�t�P�v]��gj�#�~������C�������s�_8l�����0s<�^��G�݂^�#Lǣ�#��.Z�!��0s���1.���!RO���x��q�J��YO=�?��iS�{����xε����%���i2�8W�v3�ߦ�;���z��_(·v��B���s'i7���5���k3������36���S6�|�i&��W���ٍ�i3�����&8�/؍�W�L��G�F�I>ʇ�M��qa��Hf��愐m*V�	�J���p�h��H=�x>C+M��3�9��9�����4)�a�e �f�6�� ��s��C9:7t��ф�EP���cD��x ��PF�7'��o���H|��p<�{Nf�#����Gz!�<�8{���F8BMH�#Ğ�gD��G�=�3��q��iG�=�3�C���(��ۑ�#����}U?���H�#��g�����~��p���E�n�^L�����G�Gh����[�:��W�!��o�}b<_��s#��D����'Ο�����q����O�>��q���o�>�1�q����p�q{���H��gy�����cq݋�8>��p����&hT�q���%�����ԿG�w	r
�q��{ȰG�#���4�b��GyU�'^/<!O��;&��3�ڳ\����EY�WF���s� �  