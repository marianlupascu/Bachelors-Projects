package rotl.utilities;

import java.util.zip.GZIPInputStream;

public class Base64Util {

	private java.util.Base64 x;

	public void unzip() {/*
							 * String encoded = "PUT BASE 64ENCODED GZIPPED STRING HERE"; byte[] compressed
							 * = Base64.decode(encoded); String data = new String(compressed);
							 * //System.out.println(data);AAAA";
							 * 
							 * if ((compressed == null) || (compressed.length == 0)) { throw new
							 * IllegalArgumentException("Cannot unzip null or empty bytes"); } if
							 * (!isZipped(compressed)) { System.out.println(compressed); }
							 * 
							 * try (ByteArrayInputStream byteArrayInputStream = new
							 * ByteArrayInputStream(compressed)) { try (GZIPInputStream gzipInputStream =
							 * new GZIPInputStream(byteArrayInputStream)) { try (InputStreamReader
							 * inputStreamReader = new InputStreamReader(gzipInputStream,
							 * StandardCharsets.UTF_8)) { try (BufferedReader bufferedReader = new
							 * BufferedReader(inputStreamReader)) { StringBuilder output = new
							 * StringBuilder(); String line; while((line = bufferedReader.readLine()) !=
							 * null){ output.append(line);
							 * 
							 * System.out.println(output.toString());
							 * 
							 * }
							 * 
							 * } } } } catch(IOException e) { throw new
							 * RuntimeException("Failed to unzip content", e); }
							 */
	}

	public boolean isZipped(final byte[] compressed) {
		return (compressed[0] == (byte) (GZIPInputStream.GZIP_MAGIC))
				&& (compressed[1] == (byte) (GZIPInputStream.GZIP_MAGIC >> 8));
	}

}
