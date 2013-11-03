<?php
/*
 * Gallery - a web based photo album viewer and editor
 * Copyright (C) 2000-2010 Bharat Mediratta
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA  02110-1301, USA.
 */

/**
 * @package Uploadify
 * @author Wayne Patterson <suprsidr@flashyourweb.com>
 */
class UploadifyModule extends GalleryModule {

    function UploadifyModule() {
        global $gallery;
        $this->setId('uploadify');
        $this->setName($gallery->i18n('Uploadify'));
        $this->setDescription($gallery->i18n('Easy to use jQuery uploader for media'));
        $this->setVersion('1.2.1');
        $this->_templateVersion = 1;
        $this->setGroup('import', $gallery->i18n('Import'));
        $this->setRequiredCoreApi(array(7, 20));
        $this->setRequiredModuleApi(array(3, 6));
    }

    /**
     * @see GalleryPlugin::upgrade
     */
    function upgrade($currentVersion) {
        global $gallery;

        list($ret, $params) = GalleryCoreApi::fetchAllPluginParameters('module', 'uploadify');
        if ($ret) {
            return $ret;
        }

        /* Set default plugin parameters here */

        return null;
    }

    /**
     * @see GalleryModule::performFactoryRegistrations
     */
    function performFactoryRegistrations() {
        $ret = GalleryCoreApi::registerFactoryImplementation('ItemAddPlugin',
                     'ItemAddUploadify', 'ItemAddUploadify',
                     'modules/uploadify/ItemAddUploadify.inc', 'uploadify', null);
        if ($ret) {
            return $ret;
        }

        return null;
    }

}
?>
