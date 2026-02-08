import yt_dlp

# the function takes the video url as an argument
def video_downloader(video_url):
    # passing the url to the ydl object
    ydl_opts = {}
    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
      info = ydl.extract_info(video_url, download=True)
    return info.get("title")
# the try statement will run if there are no errors

def audio_downloader(audio_url):
  ydl_opts = {
        'format': 'bestaudio/best',
        'extractaudio': True,
        'postprocessors': [{
          'key': 'FFmpegExtractAudio',
          'preferredcodec': 'mp3',
          'preferredquality': '0',
    }],
    }
  with yt_dlp.YoutubeDL(ydl_opts) as ydl:
    info = ydl.extract_info(audio_url, download=True)
    return info.get("title")

def download():
  # getting the url from the user
  try:
    youtube_link = input('Enter the YouTube link: ').strip()
    choice = '0'
    while True:
      print("Choose download type:")
      print("1 — Video")
      print("2 — MP3 Audio")
      choice = input("Enter 1 or 2: ").strip()
      if choice == "1":
        print(f'Downloading your Video, please wait.......')
        video = video_downloader(youtube_link)
        print(f'"{video}" downloaded succussfully!!')
        break
      elif choice == "2":
        print("Downloading your audio as MP3, please wait...")
        title = audio_downloader(youtube_link)
        print(f'"{title}" downloaded successfully!')
        break
      else:
        print("Invalid option. Choose 1 or 2.")
  #the except will catch ValueError, URLError, RegexMatchError and similar. Catches bad requests and other HTTP errors
  except Exception as e:
    print(f'Failed to download video\nThe '\
          'following might be the causes\n->No internet '\
          'connection\n->Invalid video link')
    print(f'Exception details: {e}')

if __name__ == "__main__":
  download()