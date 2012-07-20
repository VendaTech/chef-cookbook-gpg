Description
===========

Cookbook to install gpg, set up root's GPG trustdb in /root/.gnupg,
and install and mark trusted all the "well known" GPG public keys from
a named data bag.

Requirements
============

gnupg2    (installed from package)
gpgme gem (specified by the chef_gem resource)

Attributes
==========

See `attributes/default.rb` for default values.

`node['gpg']['keys_data_bag']`

     -- set the name of the data bag containing PGP keys to be
        installed and trusted.

Usage
=====

Having set up your keys in the appropriate data bag, include the
gpg::default recipe on the relevant nodes' run_lists. 

Data Bag Format
===============

This cookbook will set up a gpg keyring that contains and trusts the
keys you make available as data bag items. The format of those items
should be:

    {
      "id":"...",          // the key ID
      "fingerprint":"...", // the full PGP fingerprint of the key
      "public_key":"..."   // the key material
    }

The key material should be the ASCII-armoured public key material,
between identifiers of the form:

    -----BEGIN PGP PUBLIC KEY BLOCK-----
    -----END PGP PUBLIC KEY BLOCK-----    

Licence and Author
==================

Author:: Chris Andrews (<candrews@venda.com>)

Copyright 2011-2012 Venda Ltd

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
