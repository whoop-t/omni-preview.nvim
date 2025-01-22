rockspec_format = '3.0'
-- TODO: Rename this file and set the package
package = "omni-preview"
version = "scm-1"
source = {
    url = "https://github.com/SylvanFranklin/omni-preview.nvim"
}
dependencies = {}
test_dependencies = {
    "nlua"
}
build = {
    type = "builtin",
    copy_directories = {},
}
