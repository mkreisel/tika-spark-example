package extract;

/* TikaTest.scala */
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf
import org.apache.tika.parser._
import org.apache.tika.sax.BodyContentHandler
import org.apache.tika.metadata.Metadata
import java.io.DataInputStream

// The first argument must be an S3 path to a directory with documents for text extraction.
// The second argument must be an S3 path to a directory where extracted text will be written.
object TikaTest {
  def main(args: Array[String]): Unit =  {
    val conf = new SparkConf().setAppName("Tika Test")
    val sc = new SparkContext(conf)
    val binRDD = sc.binaryFiles(args(0))
    val textRDD = binRDD.map(file => {parseFile(file._2.open( ))})
    textRDD.saveAsTextFile(args(1))
    sc.stop()
  }

  def parseFile(stream: DataInputStream): String = {
    val parser = new AutoDetectParser()
    val handler = new BodyContentHandler()
    val metadata = new Metadata()
    val context = new ParseContext()
 
    parser.parse(stream, handler, metadata, context)
    return handler.toString()
  }
}