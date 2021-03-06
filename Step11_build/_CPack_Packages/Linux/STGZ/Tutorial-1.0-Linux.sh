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
� �]_ �}x[ŕ�H�ǉ�L҅��v+��@�[��؎#� p#K׶@��t�؀i�\��i�i��#���t[��v��]^�e�N�R��e�.ۺ����<ZS��I��wf����ѽ�B�n5��3sΜ���sfb�H<U֡й\���&	�����C�I������%�܍nw��>H��ˤ�p
T�#�D�CCV��������e�d*��%������򣹱Ѻ���ʹ�Z���[���亐JX�?��_�NR)B�=�R�RrX�%i)��JiEUc���ԟLI�����*��������G���ٶ# �g	�� ���v��9�����`G&!ea��������������]M�B���te�_Қk�F����P_[�R�8�wWώ@�߽U���zK�޶�`��M������HM4WF��)�U�ie>,��K"�/]�9%�Ʉ�/��&���� ॉ�Gijs?���=��d�/�E��+��P�H�u�c�=R_,����;��_C}��0���?�?�8p�7Y�cSC�^��M��P�M.w}����#���ͦ�t�؞K5���Om��������h�E\8Nٍ�D�G�rh�?������Y�s��Qe����E���y>�D��9����y3�Vç�7�V~���N�f(���F�!S�����rE(�/����D؎���|Y��O|=���z��^d�,���� �߱����ʡ�a���������ţu�X"3R7�����љN:�u�p�Nm����6�i���K)���ز�k�]w۱��?��w�l�����L���A4��K����B�"��S���C�/i�ʇKM�m��/"s�O,������-�ߵ���C�<j!�f!g�E�[,�Y���B�A9�P�m����[���E�e��-�i���"�A��&��~	Z�Z[5��5(hO�5f:�dy`(�����2���.X���XZUR���x2���0K���}n�v7&��xz��(�j4�fn��8`0O��#��������HPm��D�	�n7�)YM�cjBx@k��c9�VSJx��C.�l�	k}�,����>9���Ǣr85�Rj���Im���Ȉ������Xb�,:��������`��	XK�e�U���J����&����Ȉ<��������{]zB�(��sW����O��G��P��g�1L�s�&Wb�dF�
��
 (r�_N�
�j�@d��Fro�&倒����ZCpU��)G��ñ8%�$�P-,�Ue$1�J*�H��d$����%)d��Pe,�V�p,�����Nj۵˳�/��hk��@n�;��*�3�U�|�+!;�,E�~�ɯ"�t�_@�B�׎؜�N���Ϯ�S��|xt1�.�l CE�?n������x�*rh4���%XZ��:��r+��֎>kύ�Kc�2<����3�c����4<��|��2��_X��i��h��V#�ᓛ5��Z6�b�Gwp����Lqt��<�їq�i�~9G���U�G���W�t�n������WVp��T�B���������8:?����}G_���p��>��q�a��o֌p��}?G_����e�G/��9zG?��/��q��8�Q������W��+���~]q�;��_���p4�&U{��o��K�!��&;�Og�u ����'_N��b6�=Dp�O긝��u�A�'t������b�J��~_H�t���a_D�:^Jp��/&�[Ǘ�/#�%:^Np��W�������pȝ��N������Έ������S��Q��N����?*�.��������	xF��\��x����'o�M��7�gzB��?%�;XVA��㸞- �� ��S���`�uTMg�V5eOU\�W�g(��;I��mԞ�M����j���������Yu)(�J����^����e����7}o�&^V��l� �WB9OG�2<[�G�v��_���G/��5N�=����][C�y�ݓ�c��*>��x� �Y��)�R��o	���b@�nC2��)����Q���o���w� "p��?x�04/!�s3����h8=b�9-��T�!��or� ������>��#��'��(��}�&}�c�?!r�����﫸x�j�5m�ByM�yG!Pbrz 0�(8��$�h5��,!Z`��_���؞ӃӃD��}o����!�1�の騯a	),u��[�x��z#|ua�Ht��D3��~j��?�z�3�2@]��{w"sf|�][����3�,ԴZHͿ���<�ݷ�T�I�������1��`���:f�'\ӏ@�3��;Un}�~�7,f|�AvU)���k5�x��y�7ہJ,d�r�ȷ�( Z�{	��̔M/���=s�҉JN���xϐ�)K��m��&z�Mt
��w���eq��� }�"��9{�Ս)�8���},�����;P�������V/��T 죓�BR�_-&j�s��NWTz��֧|�cGa?�[���<⛨� ]� H�a��Kg5���"-%굯^��0$�ߟ�+��a5{��+tJ��c�M�7]w-B������'��<����59�Y���7Cm�ϡ^���:'NwN��}���ҟ�Ɵ��6�8�<��z�g��6�����~'�3�<@���
��
��
�?����(�7���T:�LHȉz��e���Df�OI�Р"��ʄS��J&U)�~���+��o�x�|�l�(�z6;��@�t6{�_�tf_���͞X������� .{��x`�d���V���$�K��@��Jۊ%K0/���Ar��}!�����t��L�����j[��}%����W7��frwc�g�Y~��~w�s�8�O�_��l���W~��V�`B�9��{:��?���Z��]Eu{
�-��m��dx�����rހ��gO_.����ſ�o����v��������pE�CF=*sz܋�ʴ��co���6�������	��J(k�w�W~��/��S��\:X�-��Dq{��c|���n-oM�����<�5[ʥ-�U[�+����=n�Mv=�����Y�7�Dp�^��=b/~ށ���I�*�v�6t��s\�\�\�\���c�B�9�1�?G�CU����R\?K@�A	=���b�s*+���3%�\
[�3o��&1<B��� =\�Θ<G��Y�1��3��;vvE���َ�4�l=��j�g��GK�z�P~vf��2��MVK����R\��gz�P�gT������t�ܵ�\�@[)�p�����G(<J�$�'(<E��0�pI%��.���p��s[��6J5�}����68��:�+C��Z�0�L�r�Ìn�ω��ܹ�^��5����H_��#}�ގ���~��zi�����H_l<l�ӗc��2$���Q�I�:P�1�W��F�%z�d�_jz���d�)})�4�/CS&���r��3ү��=#�ʴ�9�7e����<g`b����ʣiv�gE:.>;��!!?�)}R�_C��^�ZH+P�'v�w~>Q9���Q>??[��(	)*���NR}v
��+��F:PtQz������5�|�̆���L�Y�k�����8����H��דMD��y��M�b�����z����g�Է�V#��"܄��!������J͆��\�c��Y��2c�����X��/'�W"?�?et`�B>�{�}y^����>���q�_rعS6��������Kr�ނ��"-]�cƪ/X���Ȝ�bA�iA*��G,��"s��Cr^,��XO��^�@�<F������K���������bM���W�5�O�����޲��b�����DP��5��wZ�#��K>b�!�T6�d����t�h�]�:����+��\~j����[�?l������s9(�R�j���A9Y�#��%�d9���ɾp\���TZgFP$94WT%�\�j�`�&��p*����E���"G3CC���a2�TAUj쌌�#�N���Q��ҊI&�j*��/:��r,�E ��&�j,B�ưq���É�U4>��b1$o�ܱ��	,�>ٯ�M�rG��啽���8H���+{}��k ���nO���zG�b��ǰ��#��!ϖN��g����]�J4��!1�to��D��4�t%��h4�����\rOGH��r�==��}8T/c�l�2� ���r0�W���W�;@J4��3i%z�c� 6>4rV)F#!���n����<���u�aQ%�Q^J�or��~���f$��3�ϗ��Ooޕ������4�2�T�~��6֮�	��O�\ͤ������.9���p�� �(��K��@
�?�5���������n ��v�BY�K��4p9Ԉ?�{ۻ��|3��3de'�$1(��3�ַ����VθL7o��f^i0�>j�ƛZj���}����q(���h|ʬCM2����
��2��Өr�G��p@�d�p�O#g"�*N��9�JBEQG9R_&��Ţ���N �7N"gt4QhPMi>{��!D�����p\�Z@-�?�I�#�D��H@Imq��dhu*�t�1M�0�&����2��*�ngnD�d��yx(�5��@��Ex�0�g�����x*��I��`�&�+�ц���J�Y��gX%��E�?�G��"~��&�{+�M2~���`��m5Q�0���?ۗc��`����-c�x'ۿcpL����.��)3~����zA� �C�5��~ ��PN�O?��/��}Cپ��,�Q~���%Fx��҄��;��{�ۂ"�_���l�R�B��׫�7���k2(n��G~���`��?%�}� �������3,��Md�?ċQ��M��_~��R��$�}\����b�}Y�g���
����H�;e�T����"�w� 6���}������6�Ͷ~��wq�����
M���L�Q�房�f������q{^L�U�C�g�NU�_��V#�V��ů5�_?̾�
UD����h?���5���g�;�ܠ��B���s��W��Z�A�/��L�'��kh.��w1.����3֗
�F���������s��5A�774������é����$�s��v�M��<��C�*߇7J��ej�*j8o��)H������u�Ċ�v�Y��ͅ6zs�誸kAZ鿕0���Y]��s������uީ�"��N�����_�d����n��bީ�>�A�a�"����7t
1:�?���'�W�{@*:Ab�����6>��E����)6�*cQ�*��W�<w������ǉ�-�R=�|3Po']��.ff}��,S��4�11K����W��y�̷�e��h�����Z�fmZ�g6<���yk����P��O��M�[�������dk�(�d�v��������.n}�ap�sGhU&�;)B�i�\�N�'$5)*�a�?��J�D�yH{��"����p_�N���g����~\�����)���-�y$g��	�,f�N��H��d�;���cӭ,>vS3�+w2?!��v�Ȝn6'D�>+3z�����p�>D~���<;`iJ`'%n��IJ�ocr ��FH;YdN7���a�ۈ���l�Ys.vQ���<���/���$t̂��;�&�9�Â�cAǷ�T�,E2�Z�/�WL}tC�4,Z|�4�uw~�ｏ��K�)���g��gqy!���؎.j�:;Y}�!��:k��R�i_���j.B�8�e}�����p�q����)A�'�L�G�\�����6s�/������r��䳛|�-�l������G�����oG�G�����B��>W����_��i���_K\���K�@g�������]�|�>p_)�7���`�/�/40�בo���u����8		;�B~�p��������b�E3����	;fL/ʷK��Zd�1cnD8�o����z1�a�.��7 �'s�v���!�3�?�j�'�P~�mC�;~34�k���D�h�̧\yaq�*�I����{�y��/f#]�ߋ���G��Gq��Q~�Y�x��?H=qW��[�x����9ڏՎ�!�����x����P�����x���]���(.W��۹/hm8��oq�
�\gU��>
HGs�����d|����Ux���ҕ���#ðTS�R*9$��xڶ{�ze�?�*���^��a* �f�����RS+Q9�<Ox���4��Rci	����q��ܫ���b��$�|��������LJe�A��&�ΨTJ8-�����,n%S�t@Q����0�N&`�]����v�w����T�Ꞷ.�v���x�Cr�?�>c�N��������֖2U/�+-�/�I5�)dh��p
R��2�Z���q�y�*�.��e$Xq(���w0G��ola�6h�����Px��u�ӕ���*	%V���ڮJ�����5W�~(�A���T�N*S@�L�����	��+g����Px�P	��;�}�-�ªD�/:KӊZ��(~�P��wz�c��7iɯ������.��N�Cf����'���B$OO���]�	���B7K�.�v�mGw�ko�u�R�wK�V)���z���`��VL~LI�ES�~o�T�����FD���{a����c���a��j^ZpG76�dYpA��ci��������m���	
�S;.��ܱ# y�!)�Y)s��Ϸ�9��y�����w���y�NO��^ۂb���U���������O��
�瘯6Z���A�2�LD�i�p2�P��`2�J����Q̯��u`�=q�2���`���nq�_��.����7��� s��}�I�fU~̩��S�:�Z����M��HCJ� Y��	y:eo �������M���i�]�XJ�Vז��{kjKI�����Xd���7�Hld�`�0����켤'�T��*�±DZ��2q56ǋ$X/`9k�}��Ƞ���s���
�SJ8:JS�Uњ����G�0���('S�����ڋеbwR5ҕ�aPL��^�����#���0�3KS�(��O����@�.p�2�BT�F�f��ս#$с�<� 8/ml��H�#��I�򰖶MA 4�`(�����$#��1c�X\&aZ��_��_^�J�c�$��LK)j&��ɵyZ8s$��oګ�C�6�˨d$��z}�%��^{��+�Sp��>p�ܝ`��F�Q��&�3
����sYṎ�"���*�i_2�Q��G��C��i�p
�G���a��i��a�LY�1�����!���[�0O�]����ٺjV�Eq\i�2�E t����Rl��{.a]�y�v}�"�}5�����m���^��m����,��#Ux�R�ӿ%���,:����Rm�dH�Uﮫ2wfX��Ȗ�]=�C��zB�����6����jӐ;z�eX��U������O���]��o�%�ZO��-N���x�������{������+xc��=K�Aϐ��J(��Z���f�`<�j M@�!�|�B�� �.�˲����I�n0��Kkls�JK0kIЙ�#��{�dP�il��p:?m��>�H�$�!+kv���z����mn|0K����44�غ�t67�т�MP��Y���1a��U$���aIUp%���7��W�tzfh�4��d����څ�<X�W��ü�Q)Q3vFK��������Nk�1	����2��_u�&lL���e�]��$'���j�kY��[��j]��j�Z�0��6�M�A(��E���Or_$�IE�Iҝ�ԓL�c}���Ӹ���t5����*��W+��p���� s��].�vO��P4�`�׈���$�6%��.R:����3P:N��q��>���ð%E�_��K�U�B�Oz�A�U.3���Z��漆��O�*~���q��E�r(����0������y+m�3ޫ��>=��}��ILC��l���p�a���8�W�ܤ�y6���i�o�-zA�}�������Z\-��?ŉV4fE��)���r<�h=Z�^����h�K����|�.��#��H|��mF���X��i�s���R�ׁ��)�)�wj� mFȒYD����D(�/�=GÉ�����c|Y��O|=�o�z���f�ŷ��m�+� �Ϫ�ۍ��\V-��R�c�����7����mu��|}|��ӷ���?;yJ�/�_�Y�i�D�=��^����C_��U��������J&�F��Qz����.�/!��k-����f�H��̮��B��co/������k(=I����٩�O�x���V�O�����v���]=���f��in�ޔ���"c>F0�5rd��8�1������w�����<�e'vR6jyeC�m���Y[�C����.΂G��t	�ĬX�����>����P��0���Hg�$��[�������M�	����S�?�|���`����pt���3��������aN���)��^��]���s�����۬\�\�\��o���~(~bB�&U{�D��l�O�|:{�K *�&����W^�f��Uxl��I����;�����:^L�O1b���5� pE�o�^�p]��ও8������3�2Ȋ'�ZV,ʞ��?C!��<	��0�g}3����;~��=�;yV]
ƨ���~����߄�E�5���M�8�ԉ��C���d�����t2���&g�x���O�.r�������40\�qN��l,��7i,��7�~����:�&�ϑ������<|V���o��s����e�p���f��$��]����{T_�~��b����˴ �Ճ��7a�⯯Փ��@<��M����$�e?YKj��:������~��ꭴ�
��
��
��
��
��
n��b�fh[�K�������(�h�i� �=�ŷ��p
��Og�g ��u6����7��@6�������j[��}%����W7��f�X�C��%��]Rݘ�2�e�#���n7ܥ�n����>�V�'~��du{��W
i=����
��
��
��
��
�ϱ�o�;���~�e3���v����ϖ�E{��kT.�ݜ��[aNn�Ŏ��c7ʳ5̛g�ĸ��F�������w���4v�I�;S�n��Ubg�ػll��Ψ]��[h�[`ԓ�k�����[p���Y��xg(~#��ⳝ��m:v�]t.Z���P���a
��^��s�<��܅{�a��%��������v�<����뵑^��g#�X��F�����zg�����H_��s#���j|�ʀdJ_�����Sz��!r���#��������/E�L������T�e��߁.����W�_+L�U�����)}yM�k���v��,�t�@��҇z�#�:�����r�
rFI��|>l�?��ތ�e"'W�L�oR=(��է�����=��'�����٠�<v��c~-5���fo~}�����VB�ʫ�.�������7���[�g�ۦ%�_Y��fn���ܞc��\ε�mvs}�-��"�7���+/���W�Xȿ�aN��aa�I�i5������ln���^$�x�/��j2��ÙČy�������ܫƲ�PS�H{9��s�РF����o�Y��� ������^��D_{ ѷ��8�_�7<�~s���߆���/u��=����x�e���sf3����y�{VK��'����s(QwjԔ�Ss#��|혌rr�U���1�����3���r����<cN�i��V��̉ߜ���]*s�փ�y2�.�O�;2�#�����,^O��*�_���g�n���9�U����8��3(	����3��;�l�`+��oG��߇��>�l�*�K�����8[0����U�� z�L��_U��?%���s�#�����-��>ɠ�o�u���_	�l���\�?�fG|�Wi���oe�m���9[1����+2����}S;�������T�y|"�ϑ�p�~���s�����2�J�և�����9���w�٫4V�o�l�����H�E�W��:d�e��9��+���*����q�ܙ�6�_x.Z48(x��U��5X6G�_pWp�����ALE �  