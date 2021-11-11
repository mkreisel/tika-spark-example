name := "tika-spark"

version := "1.0"

scalaVersion := "2.12.10"

libraryDependencies += "org.apache.spark" %% "spark-core" % "3.1.1" % "provided"
libraryDependencies += "org.apache.spark" %% "spark-sql" % "3.1.1" % "provided"
libraryDependencies += "com.thoughtworks.paranamer" % "paranamer" % "2.8"

// ThisBuild / assemblyMergeStrategy := {
//   case PathList("META-INF", xs @ _*) =>
//     (xs map {_.toLowerCase}) match {
//       case "services" :: xs => MergeStrategy.concat // Tika uses the META-INF/services to register its parsers statically, don't discard it
//       case _ => MergeStrategy.discard
//     }
//   case x => MergeStrategy.first
// }

Compile / packageBin / mainClass := Some("extract.TikaTest")
// mainClass in assembly := Some("extract.TikaTest")