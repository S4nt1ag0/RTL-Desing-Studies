LAB_NUMBER=$1
LAB_NAME=$2

if [ -z "$LAB_NUMBER" ] || [ -z "$LAB_NAME" ]; then
  echo "Error: Please provide both a lab number and a lab name."
  echo "Usage: $0 <lab_number> <lab_name>"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LABS_DIR="${SCRIPT_DIR}/../labs"

LAB_FOLDER="lab${LAB_NUMBER}__${LAB_NAME}"

mkdir -p "${LABS_DIR}/${LAB_FOLDER}/rtl"
mkdir -p "${LABS_DIR}/${LAB_FOLDER}/tb"

touch "${LABS_DIR}/${LAB_FOLDER}/srclist"

cat <<EOF > "${LABS_DIR}/${LAB_FOLDER}/tb/${LAB_NAME}_tb.sv"
// -------------------------------------------------------
//  Main testbench for lab${LAB_NUMBER}: ${LAB_NAME}
// -------------------------------------------------------

module ${LAB_NAME}_tb;
  // TODO: Add testbench code here
endmodule
EOF

echo "Lab folder structure created at:"
echo "  ${LABS_DIR}/${LAB_FOLDER}"

