<?php

namespace App\Helpers;

use Illuminate\Support\Facades\File;
use Intervention\Image\Facades\Image;
use Illuminate\Support\Str;

/**
 * Class FileUpload is simple class for handling file upload
 *
 * Class FileUpload is class that includes methods to create directory
 * to upload files, set permission to this directory, upload files and
 * images and delete this file path
 *
 * @package App\Helpers
 */
class FileUpload
{
    /**
     * Create directory and set permission
     *
     * @param string $dir The directory in which file to be uploaded
     * @return void
     */
    private static function checkDirectory($dir)
    {
        File::makeDirectory(storage_path($dir), 0777, true, true);
    }

    /**
     * Upload file to specified folder
     *
     * @param object $request
     * @param string $fieldName The name of input file field
     * @param string $destinationPath The name of upload path
     * @param string $oldFile The value of db table column default null
     * @return array
     */
    public static function multipleUploadFile($file, $destinationPath, $oldFile = null)
    {
        if (!Str::startsWith($destinationPath, '/')) {
            $destinationPath = '/' . $destinationPath;
        }

        $finalDestinationPath = 'app/public' . $destinationPath;

        Self::checkDirectory($destinationPath);

        if ($oldFile != null) {
            Self::deleteFile($oldFile);
        }

        $ext = $file->extension();
        $fileName = uniqid().'-'.rand(100000, 999999) . time() . '.' . $ext;
        $file->move(storage_path($finalDestinationPath), $fileName);

        return $destinationPath .'/'. $fileName;
    
    }
    
    public static function uploadFile($request, $fieldName, $destinationPath, $oldFile = null)
    {
        if (!$request->hasFile($fieldName)){
            return ['success' => false, 'message' => 'File not uploaded'];
        }

        if (!Str::startsWith($destinationPath, '/')) {
            $destinationPath = '/' . $destinationPath;
        }

        $finalDestinationPath = 'app/public' . $destinationPath;

        Self::checkDirectory($destinationPath);

        if ($oldFile != null) {
            Self::deleteFile($oldFile);
        }

        $ext = $request->$fieldName->extension();
        $fileName = rand(100000, 999999) . time() . '.' . $ext;
        $request->$fieldName->move(storage_path($finalDestinationPath), $fileName);

        return [
            'success'   => true,
            'message'   => 'File uploaded',
            'data'      => $destinationPath .'/'. $fileName
        ];
    }

    /**
     * Upload image to specified folder
     *
     * @param object $request
     * @param string $fieldName The name of input file field
     * @param string $destinationPath The name of upload path
     * @param mixed|string|null $oldFile The value of db table column default null
     * @param int $width The width of expected image
     * @param mixed|int|bool $height The height of expected image default null
     * @return array
     */
    public static function uploadImage($request, $fieldName, $destinationPath = '/uploads', $oldFile = null, $width = null, $height = null )
    {
        if (!$request->hasfile($fieldName)) {
            return [
                'success' => false,
                'message' => 'File is not provided'
            ];
        }

        $file = $request->file($fieldName);
        $image = Self::imageUpload($file, $destinationPath, $oldFile = null, $width, $height);

        return [
            'success' => true,
            'message' => 'File uploaded successfully',
            'data' => $image
        ];
    }

    public static function imageUpload($file, $destinationPath, $oldFile = null, $width = null, $height = null )
    {
        $finalDestinationPath = 'app/public' . $destinationPath;
        Self::checkDirectory($finalDestinationPath);

        $imageResize = Image::make($file->getRealPath());

        $ext = $file->getClientOriginalExtension();
        $name = rand(100000, 999999) . time() . '.' . $ext;
        
        if (!empty($width) && !empty($height)) {

            $orgWidth=$imageResize->width();
            $orgHeight=$imageResize->height();
            if($orgWidth >= $orgHeight){
                $imageResize->resize($width, null, function ($constraint) {
                    $constraint->aspectRatio();
                });
            }else{
                $imageResize->resize(null, $height, function ($constraint) {
                    $constraint->aspectRatio();
                });
            }
        }

        $imageResize->save(storage_path("{$finalDestinationPath}/{$name}"));

        if ($oldFile != null) {
            Self::deleteFile($oldFile);
        }

        return  $destinationPath. '/' . $name;
    }

    /**
     * Delete the file path
     *
     * @param string $oldFile The file path to be deleted
     * @return void
     */
    public static function deleteFile($oldFile)
    {
        $finalDestinationPath = storage_path('app/public' . $oldFile);

        if (file_exists($finalDestinationPath)) {
            File::delete($finalDestinationPath);
        }
    }
}