module DirectUploadHelper

  def blob_for(name)
    ActiveStorage::Blob.create_and_upload!(
      io: File.open(Rails.root.join(file_fixture(name)), 'rb'),
      filename: name
    )
  end

end
