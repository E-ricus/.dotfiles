return {
  "xbase-lab/xbase",
  ft = { "swift", "xcodeproj" }, -- etc
  build = "make install",
  config = function()
    require("xbase").setup {} -- see default configuration bellow
  end,
}
