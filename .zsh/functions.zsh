# Create Video of hevc
hevc-convert () {

  filename="basename $@"
  extension=${filename##*.}
  filenameWithoutExt=${filename%.*}
  transferedFilename="$filenameWithoutExt-hevc.$extension"

  codec=`ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 $1`

  if [ $codec = 'h264' ]; then
      ffmpeg -i "$1" -c:v libx265 -preset fast -crf 28 -tag:v hvc1 -c:a eac3 -b:a 224k "$transferedFilename"
  fi
}
