run("Tree Rings");
makeRectangle(0, 0, 1794, 162);
Stack.setXUnit("um");
run("Properties...", "channels=1 slices=1 frames=1 pixel_width=2.78 pixel_height=2.78 voxel_depth=2.78");
run("Crop");
saveAs("Tiff", "C:/pythonProject/pyterrastitcher/images/Tree_Rings.tif");
for (i = 0; i < 13; i++) {
	selectWindow("Tree_Rings.tif");
	makeRectangle(i*136, 0, 162, 162);
	shift = round(i*136*2.78);
	run("Duplicate...", "title="+i);
	saveAs("Tiff", "C:/pythonProject/pyterrastitcher/images/res_"+shift+".tif");
}
