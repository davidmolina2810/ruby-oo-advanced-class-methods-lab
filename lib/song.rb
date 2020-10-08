require 'pry'

class Song

  attr_accessor :name, :artist_name
  @@all = []

  def initialize(song_name=nil)
    save
    if song_name
      @name = song_name
    end
  end

  def save
    self.class.all << self
  end
  
  def self.filename_parser(filename)
    dash_index = filename.index(/-/)
    mp3_index = filename.index(/.mp3/)

    artist_name = filename[0...dash_index].strip
    name = filename[dash_index+1...mp3_index].strip
    return artist_name, name
  end

  def self.all
    @@all
  end

  def self.create
    self.new     
  end

  def self.new_by_name(song_name)
    self.new(song_name)
  end

  def self.create_by_name(song_name)
    self.new(song_name)
  end

  def self.find_by_name(song_name)
    @@all.find {|song| song.name == song_name}
  end

  def self.find_or_create_by_name(song_name)
    find_by_name(song_name) || create_by_name(song_name)
  end

  def self.alphabetical
    @@all.sort_by {|song| song.name}
  end

  def self.new_from_filename(filename)
    artist_name, song_name = filename_parser(filename)
    song = find_or_create_by_name(song_name)
    song.artist_name = artist_name
    song
  end

  def self.create_from_filename(filename)
    new_from_filename(filename)
  end

  def self.destroy_all
    @@all = []
  end

  
end
