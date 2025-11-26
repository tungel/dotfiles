#!/usr/bin/env python3

import os
from pathlib import Path
from lxml import etree

def dms_to_exif_decimal(dms_str, ref):
    """Convert '50:52:31.181' or '50;52;31.181' and 'S' into '50,52.518661S' style"""
    try:
        # Normalize separators (replace ; with :)
        normalized = dms_str.replace(';', ':')

        degrees, minutes, seconds = map(float, normalized.split(':'))
        decimal = degrees + minutes / 60 + seconds / 3600
        return f"{int(degrees)},{minutes + seconds/60:.7f}{ref}"
        # return f"{decimal:.7f}{ref}"
    except Exception as e:
        print(f"Error converting DMS: {dms_str}, ref: {ref}, error: {e}")
        return ""

def extract_metadata(xml_file):
    ns = {'ns': 'urn:schemas-professionalDisc:nonRealTimeMeta:ver.2.20'}
    tree = etree.parse(str(xml_file))
    root = tree.getroot()
    md = {}

    def xpath_val(expr):
        val = root.xpath(expr, namespaces=ns)
        return val[0] if val else None

    md['CreateDate'] = xpath_val('//ns:CreationDate/@value')

    device = xpath_val('//ns:Device')
    if device is not None:
        md['Make'] = device.get('manufacturer')
        md['Model'] = device.get('modelName')
        md['Serial'] = device.get('serialNo')
    
    vf = xpath_val('//ns:VideoFrame')
    if vf is not None:
        md['VideoCodec'] = vf.get('videoCodec')
        md['CaptureFps'] = vf.get('captureFps')
        md['FormatFps'] = vf.get('formatFps')

    layout = xpath_val('//ns:VideoLayout')
    if layout is not None:
        md['PixelWidth'] = layout.get('pixel')
        md['PixelHeight'] = layout.get('numOfVerticalLine')
        md['AspectRatio'] = layout.get('aspectRatio')

    af = xpath_val('//ns:AudioFormat')
    if af is not None:
        md['AudioChannels'] = af.get('numOfChannel')

    # GPS tags
    lat = xpath_val('//ns:Item[@name="Latitude"]/@value')
    lat_ref = xpath_val('//ns:Item[@name="LatitudeRef"]/@value')
    lon = xpath_val('//ns:Item[@name="Longitude"]/@value')
    lon_ref = xpath_val('//ns:Item[@name="LongitudeRef"]/@value')
    if lat and lat_ref:
        md['GPSLatitude'] = dms_to_exif_decimal(lat, lat_ref)
    if lon and lon_ref:
        md['GPSLongitude'] = dms_to_exif_decimal(lon, lon_ref)

    md['GPSLatitudeRef'] = lat_ref or ''
    md['GPSLongitudeRef'] = lon_ref or ''
    md['DateStamp'] = xpath_val('//ns:Item[@name="DateStamp"]/@value') or ''
    md['TimeStamp'] = xpath_val('//ns:Item[@name="TimeStamp"]/@value') or ''
    md['MapDatum'] = xpath_val('//ns:Item[@name="MapDatum"]/@value') or ''

    return md

def write_xmp(metadata, out_file):
    xmp = f"""<?xpacket begin='﻿' id='W5M0MpCehiHzreSzNTczkc9d'?>
<x:xmpmeta xmlns:x="adobe:ns:meta/">
 <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
          xmlns:tiff="http://ns.adobe.com/tiff/1.0/"
          xmlns:xmp="http://ns.adobe.com/xap/1.0/"
          xmlns:exif="http://ns.adobe.com/exif/1.0/"
          xmlns:xmpDM="http://ns.adobe.com/xmp/1.0/DynamicMedia/">
  <rdf:Description rdf:about=""
    xmp:CreateDate="{metadata.get('CreateDate', '')}"
    tiff:Make="{metadata.get('Make', '')}"
    tiff:Model="{metadata.get('Model', '')}"
    tiff:SerialNumber="{metadata.get('Serial', '')}"
    exif:GPSLatitude="{metadata.get('GPSLatitude', '')}"
    exif:GPSLongitude="{metadata.get('GPSLongitude', '')}"
    exif:GPSLatitudeRef="{metadata.get('GPSLatitudeRef', '')}"
    exif:GPSLongitudeRef="{metadata.get('GPSLongitudeRef', '')}"
    exif:GPSDateStamp="{metadata.get('DateStamp', '')}"
    exif:GPSTimeStamp="{metadata.get('TimeStamp', '')}"
    exif:GPSMapDatum="{metadata.get('MapDatum', '')}"
    xmpDM:videoCompressor="{metadata.get('VideoCodec', '')}"
    xmpDM:frameRate="{metadata.get('CaptureFps', '')}"
    xmpDM:pixelAspectRatio="{metadata.get('AspectRatio', '')}"
    xmpDM:audioChannelType="{metadata.get('AudioChannels', '')}">
  </rdf:Description>
 </rdf:RDF>
</x:xmpmeta>
<?xpacket end='w'?>"""
    Path(out_file).write_text(xmp, encoding='utf-8')
    print(f"Written XMP: {out_file}")

def batch_convert_mp4_xmp():
    for mp4_file in Path('.').glob('*.MP4'):
        xml_file = Path(str(mp4_file) + '.XML')
        if not xml_file.exists():
            print(f"Skipping {mp4_file}: no corresponding XML file found")
            continue
        metadata = extract_metadata(xml_file)
        xmp_file = Path(str(mp4_file) + '.xmp')
        write_xmp(metadata, xmp_file)

batch_convert_mp4_xmp()

