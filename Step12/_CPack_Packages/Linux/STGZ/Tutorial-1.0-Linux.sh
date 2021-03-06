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
� v�]_ �}x[՝�d'��XNH�M�\�<dɯ8I�X��HD~`�h�F��m��k�����|&&�v��eۯ�N���Я�L�Ni�3��N`�ۥ��n���7P&�I��s�9W��k;�d�����=��y��X"OG�j�	���^��^ ӳ��͚:	���5�k������S[���O2P��)%����-K���ࠕ�龓x������9Ǜ�D_��50�~@z4��Y���M-���5�$�g3Vt��u��HBD��tR�
��)!��
)IQb����''ZD�WF��XB��V_Ww��]l����%x�ph���X���mae�5���y?����_�����:w��|��T�2�'h�5Z)�h���*^)�����
�o�no���w�|Z|���N_� �Q)OI��h<.�IEu*�S�LXb�Y�D4�W�s
�B%䄰7���{S�+'ܩ΋�A)5�H� ��>Z�����r�7�x��7�Tp�jS�+�E�%>ѱ�����4x���A8�i7�I����2��j��]|p{���|�9�O|�V�ͦ�h¶g�j�&�?�5�ӄ�B�+�h�w����h��h|e�Λ�"�iĉ)�st��D�Y�B�Λ��M�O�O 8g>a7�,N���j��>k4�H<���o��M~�h��F��g��H��&|�o'qǛ-�h��v��D/ſN�'x3��&�����fN4{��V�P�0���U�c�u���x,�^7�ذ��Ε�]5z���Lmo���vc&�K�����n;�P�ő��[>�����Ee؈D�Ӣ���e([����{�~B�o�K�X�l���M�[��!s��x���',�,�o[�����/X�r6X�_e�~2�l!�'�+,��p#�����������5�Y���
��M��/B�QS�f/�
�q�	UɃD�PN��VD��P�	�R,�H�P[s\NH�0�ӵo�_�h����ux��bOSJ4�f��;��)_~u+u0m�"݊�={RT�ᘒ
D|�.�j{éXD�SJR
Bb�-��DM��M�%RRR	D�{9$�2k�DQH�{��p<������P:wDTV�1&�D.�1����x4޹'��8$%Srx�q�[��ii@����ݵb\�Of�	k�h�f-䀯��������=��7bw{�/>(��Tj^D䴢����  ��'&É~I�@���~�JJ&�$�9��I��I����%� ���)��E�#��}�XAX9����@8"a6��`�	|��q�B��`dh�8�)(��}P�D,���p,��77��.7�lk޹~׹j<~z�D����ek�~�5�/O�g��Utt�ګ].�E������9����Ki��o�=�̹�"4��CՍ��m��+�Nt�82���l kҾw¿{�~��C���{����>�'Uvܣ��R��"�׵z?�@���~|I,���������9���!����<�̈́���t�q�j�<��Cd�;���}Q���d<��d���2�U~���f�	���'����2�g���7�����x�������(;�Q�38;�3���;���d�B����xn���2��1�0��c���.�<�����/`�'|!�f�����,��2�g�ף����3�R��<���������V���QŞ9�}��E�{����*��{uw�̩_f2�C�ݦ����v�~L�;T�wu{�j��n/T�_��sT�������^�^��ú}�j�E��v�n���=�}�j�A�/T�t{�j��v�j��j/���i��틵�S;���©ע�7���h�g�k��-��5��e�~�����8{��rv�����{8{g�q�͜�������M(�h[��Bn8�Nl�|񏝞�˗�6��o���?�>�Q�x��J��XK��st4cs>��R�x�(x0^��������o���c��'�薊���K�ѳN���\�gm�g����|(xP�({�������� ��W
� $N����؇ �e\xU�F��'n��Yyܿ)^Q�|�5�7�=[�|�'���Qc<�g��TL�錳tAp(XQ4�0`�����`}x66��B�s.*��ء1�;��3N�1K�Ʋ���
Q��^s��"8��{a�MM�W'��3�Q�x����.P�y`��/��ܝ�]�;�wy����e<oB�'���yUK���c��7��^�.� l/����>�����+=��e��C��,~7,�a76���nzqq"O<u^��s�p��n��.wbO���Z��c��YgK��k~N�R�`�N����������j��>�����fpN$���k�T�Mhu&ڴ߯��o�o�y{�T=�˷���?b��̓�Քxir�����S[�k�˹�A�9W4�����޸��:��������V�1������Yj9�GX��*K����UZS?/sҹb?��"1��M������I�������u�m��߸�,? �2'��xQ~���"PzM�t��Uj�[Y �|,�� �� �R�:���	��S{38�t������knD�{k`�x{c����c�z��U ��:��t��#H�c��
��	p�Lp콖�w��%��?��Ϳ������)�}�4������zO��<�)Oy�S����ِ	�J�TLNȅzR�~i���Dz�WJ�^HB��t8)	IYV��R�+�7�}9�tD	� ��F�k�c^�����d����L�0~�ɼfݙLf?�fC`����3�'��&>�R�a&�}��s�����.d.�-_0����فd2������[��*��&<�/)m-)��9o�~�u��յ���{�M>v��
�k��,������!���p=B�ix:�ߝϧa�Y0�֒����J�ul+l+�|��[�~h���qt���C6�n[qI#`ޒJpn���n+)��%���~z�~��܇�<Rx��Q�cvv�g �+p���Əח���������/)��D[m���Q�6�(a@s �ه���an�a�kanJ��W]�|�9�zp&c[��1B�.�z!�,c�)Oy�S��<�)O3 zރ���9�sĬ��������:b�C��2I�g��azF��GYnt����O�<��u��������?:4 �'����;=��0�ӳ�	v�����z��8�8�_�3����F��bc��O�fP��GFw�h���Wyb��$�I"�#b��L��!z�'7��&bvs71�������y����(1O�$1'i!�yJ�)�M�&bv��~.��&Jۛ�7
�=�鄒6�j]�uwZ��Ti��2�2�n�ωq�~�܈�L�B�^�9z}0�s�zcċ��d����Ј��݈���_`<����`����&��@N4d����&�tPxʮ1���u���s�F|	:j�/E�M;��z{gį��9#^fZ��z
[��e�&<{�؈_��i�:~��q|��Τ�
����'5_��Z�n�f�b�d!���9�5�~��^m�?G�N�������_�����!rqr�����/�𿩺_�0�w3�'տ�����z�*?�<�S�^���6�Ï��I�i�8���,CeMF��\Ur���l�i��#���m3?����7!������Ӥ~�������e9��i�׃��==J�ݍ�V� c�=�݈Z����-�oY���@��K�?�p�_��҇����G���th���"��,G;�F�;�ߴ������<k���-}��+|]���|�~�����_Z�?f�/-��YJ���*4w�Rh�o�>h!)��+2<��1|WD�G��=ر��T�Wh���E�`�(��X"��HRI)�>We���ʠ�WLRH����{�q1
���pzE�����HQW��~��#|I &�����(%���K�%1������bp*��]�6��ko�7c���=��O@K[no���ᛁ9jԋ	z:t��v�BbȻ-�s�845�WD)V�Ht��h,!�SR���`�ЮQpR.���CnF@
�dq �����y[ns%�>���k%F)�]c�;!Y�Sg�D�'���E��n��ic�֒��5�R4���Apm�����7(E�NuÇO�[]�؛J�M/&�AP��DRi�bX^�ʉ�Iyijb����8����f��|��,ܤ2�����D�W���ir���=6c" WjdP	��	�F5�XD!WBV$W"�Jʐ����c��X�@���p?R��S�I���$�/{��l�E�oI)�ɯ���Ce�t���GJ� �\��)�J�j�Hk=Mfm�MZ��4����6�lӫɠ����`�k�#�q{e֟]$�u%<t��7V��)�8�Jd��cu��Rgo���{��{~�&�����������3���ujV�N������V��9��a�ޗ��t]+��w��:5��#����~�A�F.�v��<��Ψ��[P�Y����� �Ҕ���j��<>�h��B��;]��q��3&��@�w��>{w����*�O�U���%8��w8~��BM~������4�tO��9~��@�4a><?������9�|��������ݜ{�����[��`���9~�ޤ�\�������u)j�q����oH[���T'���ӻ�36����k����;mZ��������f�����i'~=_ ���_f3���^��˧���>���2��%x�ъV��Ue���f�8v�KM��a`��P�r۟yL�Y:N�/qg���Ȃ��-���c������������������u��*�M��#��l�1������:��������8���}�t�g������j�H��n��H���#D��}�����n�>��I0Km����XTJ�"&������c��2�ǆ6�� ��璫�.\�ꡘ�0���Ȼf<��K�M���h�q,��=��>��ߪ�LGS�笞P�\:G���5�j���sV�L.>�,%�ꗜ_��{p|�����ػ��9���t��4�کi�U�}צ]�t>�L����A�Ϝ���cg��Soo>����j{{�s�	 p���]�n�q��\�/}�z�x�{����H�N�7H��/�Ǒ�i"8�L�$ m��,�w��F��<pSF�*�������ȃ��@���������S�Weq���I4J�l�ߙ8zjn�~ ��k�ї�p�}/�|$��[kH��
��ǟp�~�܁���řA��l8�\�ݫ��'�]�Nm���U1�)�9?�D��g'̪G�[���<���x����#ݵj���������豆G�p4�Q��>����ځ����ٜ� ���M��zR�����8!(�0 Ň��X"*�^������~ZP�<8��>��j����>1�V�xs�7����)}*7�,��������O�'L?�J㭙$�'�����t�Y��<t-������5[� �����������Dx��[R9Z�R��x�V\R�+��X{�|�}8�?;oF��|�!�\�9n~�Ł��;��!��0����@��"�qv�����S��]V�ɡ��0ǝ��a	��s�i��waG5���L��776��o!���f�'?�y�ԿV�Rb���d]�;g�J���L��J~B�GRз-�g-���b����q�ޥ�g��Nb�p�X��X��ĸI������E}��o+��͵�O���i��7������-Y��1O��w˵Ъk����x:5�>�6��Y��g���ܨ�S�b ����9����pJ�3��sf��v
�'�ZE�g9�_�T�Z_����Sܞ\����%�z�|���������W1�O9����70��2r�0�i9th�������c˦�2�ߖ�w)��2���=F��?f�_��2�a������!���o�g�]��W��㻚q��w㾂�ig'�(N���bpz�˿���971x��|#���	lث@(���尣�:g��!7�]S��;l�&�ׅ���j��<�F���u����!��m�%�R�{k��!�ש{䦛��$fS/)��Ь��B�dt�]��i��>.g�����P�\S'1�r}�g-G���)��}�����l��э�[&D��vr����"�0����zJ��C�9|M�#'>�]���Ë�:����'����.�F�G�y�|�q14˿!r�������r��ad�נD�#�ۗ��q�?���&��9��ϟ�:���Z�O����#�����W�|��f��&n�C�oab:9�}�7��������Y�_��~b��妿վ}w�-<fXf�o�/��8|~�}�}��$����O˾ȕBd���i��#u�g�E����֭�CB�i�\�\=�9]�����?��<��O���������Ӑ���d����{i"��MY��e>��fp��Tw��3�3���r�ќ�>�glF���r���l6�����r���l4'mF�׫��|y�>�w���Mz��q���c�X��>�!�7���|\},V��M���oş:ܹ�����h�O���ܛF��"ߝ��}�@@N"��G^�~��?��-��!��"6��X�`�7Z�����3�����Z�G3�����|��2��E|�E8���}������#m6d���{oWׇ���&�N�_B8^%�Y���gG������Vp�Z����q��[N�KV�����=�n�l���to����������B��F���zՖ��>��~w�#̞�����O���/ÁlvV�]ߛ����n�zp��i�}��K���M�{b�z� �|�8���=���]�a�_�sYV�����`�T��/�v�������B`pvZ��������ZL#���M��r���+����.�N7���S��<�i�����]s�/������ӫ�B����/���9�:ξ��_��y�9{!g?��{!���7dT}m.��ܿ��ssA�z��^���P��o���o��5���jM�k
��X7����meM�sx�N�7� ����o��k&�N}�Q��t�h��=G�Å�9Z��i�Ѧ�������.Yh8G۴���/ϫ�S�s�0JE&��ht^��B���TU3r)�h=�i~��z�L��޾@;G�͋9G{lM����s�o��a���{�lx�N��}kr��ުjA1���cw���s���s�y�y�S��<�)Oy����l����.��%�ҳ�3��`vNf2���n0c.0�{#���d�`�3����2�$�V���8���?�ɚJ���ӹ�]�ޗ#��p|�ab�/0�#�o��L��O��^n/�>>3|�t�.�<�)Oy�S��<�)OW&��_����N�>���-=[��S}6גC_V�l��	�gCϣY鳡�Ϭ��L��Y�Ir��1��陰5�=�φ�N���V�k����i������b���$�k��OZ?��%z�����oC�Όf����_������C/�F� {�����ވ��ˏ���;#^��_#>O/�F��B�|}4t=EF|���Ȉ[믡�/��G�H��`��#��Uz�dė��_jZ������zg���;SfZα���L�e9�ջ@���lz����YS���rꉜ�\��'�	����!���_/ꯌ4�0|:?N�trr���>7��Y��*^���Y�����b������r������������	�zj�����|y�R���Vc����G�{"w���q�-���f~��m��������X�a�b7��b7��r�n~�;�X�OYa�ow��������{%3}�S�n�x�B��
H4��E���xt�%D��e^����4wQ�z<�*���UK��:?f�+a6n!�h]1Q���* a.&�$�4n����O9���KM�(��TM|��KL�JDk�}":%0-G��/��R⇛.���>+%~8�EF�t|M�:���2�u����R�xʾ�D�{�Ȩׁ�ש�����W`�}&�t\O����9��f�:��?5w�l�s�hڋ�z�<��t�˧���"�^:��&��5&�����ux����:����ɿ���y5����$�O�;�d���������J������%�OǧԜN��ߢ��:��\����9~���V��z%輍�L��?!��E�}qr|:�X�����O��3����2���	�$�~�|4\_F�����(yu�i�'9~��,_잆�#���Kv�a�_��d|���w�r��ķ6���(���u@�?��h����k�i��X�_��F�\8��G�v��D��H������PW[���pY(���	ଖ������O>�/Y��
'�%%�.!G�D_�ߥr�؏��r��6���舘�5�Zw����A+�}L*^)l�R2�HQ��ʅ���E��IE��%W���<j��m8M	��!!���,ܓ���GX���`Xȼ�U�����6��h���
����O�����h<UXb@#	q��ԗc��V��IU?�P^�Ŋt�2����	>����ko:�::}]���{_���������A����Reja��cR��(��������`G�*M���i�;�|������|䭜��юW���L�0$_<�R*Id���~_�QK�n.]����y�-�vt�F����`���z���U�k��i����b�=��j�6�Ġ�}{�w;$N6S�w�,��B`��4�d�=�ld9f-��Z�+��	����0$�����񨐐���?�z_U<}�x%ь���K���4M��^_א}����Y箭�������i$�����A��KʃBS��y4;�BMB��dJ�P8rO�_5D�|e�@���	����S����;���q|gD��7S)���:���2�H��A^��Ci�H	��\�b	a
ZI�W�d,!��񶚜�J%���@�-�.�li�HsOW��=Mswه���/�ۺ;�=!_����J�űD$��JB�T2�k	�[U�������6 ���������������;TB��A����Z��f��I��ϥÁv.���j\�U0��T
Z��Vo�}]]P��z�e3�jp���to:����U�R"
>V��K���HegO�����T��?�̥3)+RD���X"�����6�,g��w ��c��p, ���xR
GGH,qP��-�����.@ND$aPNJZX�86�"��R�� �ˊ��� `R��U�=)�p�%���X8��ɐ�I�/�O�CO\�cO�+ƙFhf����Ȩ��'8'nl�䪞\�3�&M�*R79P�C]�[z�Au��%̾r,.�0�L������L�i�ق`���KJJ:����y�9�DI�i��-B���<+��Uzy��:ꀰ����J���
�<r�J��C��(�&��3�����I�"���*�I[� ��.��gm;��a�APb{$è�e5�1N�,�8g!?:�!h�g,���}Z�!G8��rV]NK6/��M�P� �&�آC[*Ƶ��[���{�|-�D^�
��Bho����8�����f3n2�,7����.��f��Ok&C��Zw=(�'���di�h��R������)%*z<�.;:�5��]���)�W`Do{�h�ؼs�ZoW[s�5k�C��j?����{�lܲij���[����I�tz�ddWU�C�P�y�t�^r��b U@k!�x���:�ŋp��uH�B#a���W�҃0�`Ԓ�'#1U� '�~5��.c���(4~��	�}xQw��E��4��Y��3=C���r�QGA[bӖ�Ԋf9[��L��c�>�-X� E�������z{\D�R8�	��{9�q)E�g��N�GR'ظG̖.	�%�x��ÓnwBG2"�#J܎@o	�=��<f�ú�>_��X�evE��~M�>�K��vBb�)��+'_-�Pnm�U���UE�zy����5�wQv���BvA"*KZ��F�%�r*�UKi8�[^�A�W���DTR����X�(������>2 �r���Ղ7AK(v�NP�׈M��$�8�_!��@\R}i�	�����c���a0�f1�%��4�VE�$?��V��t�k��J�>T�.��n�E��Z�C����@n<�Ι�h���	�J0��ƀtuG1���n<����b���0�2�F�eX��*_���E��B�B��u����j�����zO~��r��YE1�s��
S��v����i�fq����y�}��CLd���.����2g/e�x�|���z�XnO_�{�WYT�Y���?��<V�g5hW|���<��ʥ���� �  