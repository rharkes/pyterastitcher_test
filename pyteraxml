from lxml import etree
from pathlib import Path
from tifffile import TiffFile

xmlout = Path(Path.cwd(), "Tree_Rings.xml")
pth = Path(Path.cwd(), "images")
tiffs = [x for x in pth.glob('*.tif') if x.stem != 'Tree_Rings']
file1 = TiffFile(Path(Path.cwd(), "images", 'res_0.tif'))
xy_res = file1.pages[0].resolution[0]  # um/pix
root = etree.Element(
    "TeraStitcher", volume_format="TiledXY|2Dseries", input_plugin="tiff2D"
)
etree.SubElement(root, "stacks_dir", value=str(Path(Path.cwd(), "images")))  # root dir
etree.SubElement(root, "ref_sys", ref1="1", ref2="-2", ref3="3")  # ??? no idea what this is
etree.SubElement(root, "voxel_dims", V=str(1 / xy_res), H=str(1 / xy_res), D="1")  # in um
etree.SubElement(root, "origin", V="0", H="0", D="0")  # in mm
etree.SubElement(root, "mechanical_displacements", V="0", H="378")  # in um
etree.SubElement(
    root,
    "dimensions",
    stack_rows="1",  # n rows in 2D matrix of tiles
    stack_columns="13",  # n columns in 2D matrix of tiles.
    stack_slices="1"  # n slices per tile (max)
)


# For no apperent reason the COL value is changed when importing the data! Therefor file entries need to be ordered.
class teratif:
    def __init__(self, pth:Path, col:int, row:int):
        self.pth = pth
        self.row = row
        self.col = col

    def __lt__(self, other):
        if self.row < other.row:
            return True
        elif self.row > other.row:
            return False
        elif self.col < other.col:
            return True
        else:
            return False

    def __eq__(self, other):
        if self.row == other.row and self.col == other.col:
            return True
        return False

    def __str__(self):
        return str(self.pth)


tiffs = [teratif(tif, 1, int(tif.stem[4::])) for tif in tiffs]
tiffs.sort()
stacks = etree.Element("STACKS")
for tif in tiffs:  # for every file
    stack = etree.Element(
        "Stack",
        N_CHANS="1",
        N_BYTESxCHAN="1",
        ROW=str(tif.row),
        COL=str(tif.col),
        ABS_V="1",
        ABS_H="1",
        ABS_D="1",
        STITCHABLE="no",
        DIR_NAME="",
        Z_RANGES="[0,1)",
        IMG_REGEX=tif.pth.name,
    )
    etree.SubElement(stack, "NORTH_displacements")
    etree.SubElement(stack, "EAST_displacements")
    etree.SubElement(stack, "SOUTH_displacements")
    etree.SubElement(stack, "WEST_displacements")
    stacks.append(stack)
root.append(stacks)
dom = etree.ElementTree(root)
dom.write(xmlout, encoding="utf-8", xml_declaration=True, pretty_print=True, doctype=r'<!DOCTYPE TeraStitcher SYSTEM "TeraStitcher.DTD">')
print(f"Wrote to: {xmlout}")
