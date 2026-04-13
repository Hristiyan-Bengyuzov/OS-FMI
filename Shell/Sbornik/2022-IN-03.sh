#!/bin/bash

arguments=$(mktemp)
options=$(mktemp)
after_jar_file="false"
after_jar_option="false"
jar_file=""

for arg in "$@"; do
    if [[ "${after_jar_file}" == "true" ]]; then
        echo "${arg}" >> "${arguments}"
        continue
    fi

    if [[ "${after_jar_option}" == "false" ]]; then
        if [[ "${arg}" == "-jar" ]]; then
            after_jar_option="true"
        elif [[ "${arg}" =~ ^-D[^=]+=.+ ]]; then
            # ignore -Dproperty=value if before -jar option
            continue
        elif [[ "${arg}" =~ ^-.+$ ]]; then
            echo "${arg}" >> "${options}"
        fi
    else
        if [[ "${arg}" =~ ^-.+$ ]]; then
            echo "${arg}" >> "${options}"
        else
            jar_file="${arg}"
            after_jar_file="true"
        fi
    fi
done

arguments_str=$(cat "${arguments}" | tr '\n' ' ')
options_str=$(cat "${options}" | tr '\n' ' ')

echo "java ${options_str} -jar ${jar_file} ${arguments_str}" | tr -s ' '

rm -f "${arguments}"
rm -f "${options}"