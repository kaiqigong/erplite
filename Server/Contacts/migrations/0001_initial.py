# -*- coding: utf-8 -*-
from south.utils import datetime_utils as datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding model 'Contacts'
        db.create_table('Contacts_contacts', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=255)),
            ('avator', self.gf('django.db.models.fields.URLField')(max_length=200, blank=True)),
            ('description', self.gf('django.db.models.fields.TextField')(blank=True)),
            ('createdDate', self.gf('django.db.models.fields.DateTimeField')(auto_now_add=True, blank=True)),
            ('createdBy', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('modifiedDate', self.gf('django.db.models.fields.DateTimeField')(auto_now=True, blank=True)),
            ('modifiedBy', self.gf('django.db.models.fields.CharField')(max_length=100)),
        ))
        db.send_create_signal('Contacts', ['Contacts'])

        # Adding model 'ContactTag'
        db.create_table('Contacts_contacttag', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('contact', self.gf('django.db.models.fields.related.ForeignKey')(related_name='tags', to=orm['Contacts.Contacts'])),
            ('tag', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('createdDate', self.gf('django.db.models.fields.DateTimeField')(auto_now_add=True, blank=True)),
            ('createdBy', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('modifiedDate', self.gf('django.db.models.fields.DateTimeField')(auto_now=True, blank=True)),
            ('modifiedBy', self.gf('django.db.models.fields.CharField')(max_length=100)),
        ))
        db.send_create_signal('Contacts', ['ContactTag'])

        # Adding model 'ContactData'
        db.create_table('Contacts_contactdata', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('contact', self.gf('django.db.models.fields.related.ForeignKey')(related_name='data', to=orm['Contacts.Contacts'])),
            ('keyPair', self.gf('django.db.models.fields.TextField')()),
            ('valuePair', self.gf('django.db.models.fields.TextField')()),
            ('createdDate', self.gf('django.db.models.fields.DateTimeField')(auto_now_add=True, blank=True)),
            ('createdBy', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('modifiedDate', self.gf('django.db.models.fields.DateTimeField')(auto_now=True, blank=True)),
            ('modifiedBy', self.gf('django.db.models.fields.CharField')(max_length=100)),
        ))
        db.send_create_signal('Contacts', ['ContactData'])

        # Adding model 'ContactLink'
        db.create_table('Contacts_contactlink', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('contact', self.gf('django.db.models.fields.related.ForeignKey')(related_name='links', to=orm['Contacts.Contacts'])),
            ('entityType', self.gf('django.db.models.fields.TextField')()),
            ('entity', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['Contacts.Entity'])),
            ('createdDate', self.gf('django.db.models.fields.DateTimeField')(auto_now_add=True, blank=True)),
            ('createdBy', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('modifiedDate', self.gf('django.db.models.fields.DateTimeField')(auto_now=True, blank=True)),
            ('modifiedBy', self.gf('django.db.models.fields.CharField')(max_length=100)),
        ))
        db.send_create_signal('Contacts', ['ContactLink'])

        # Adding model 'Entity'
        db.create_table('Contacts_entity', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('name', self.gf('django.db.models.fields.TextField')()),
            ('createdDate', self.gf('django.db.models.fields.DateTimeField')(auto_now_add=True, blank=True)),
            ('createdBy', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('modifiedDate', self.gf('django.db.models.fields.DateTimeField')(auto_now=True, blank=True)),
            ('modifiedBy', self.gf('django.db.models.fields.CharField')(max_length=100)),
        ))
        db.send_create_signal('Contacts', ['Entity'])


    def backwards(self, orm):
        # Deleting model 'Contacts'
        db.delete_table('Contacts_contacts')

        # Deleting model 'ContactTag'
        db.delete_table('Contacts_contacttag')

        # Deleting model 'ContactData'
        db.delete_table('Contacts_contactdata')

        # Deleting model 'ContactLink'
        db.delete_table('Contacts_contactlink')

        # Deleting model 'Entity'
        db.delete_table('Contacts_entity')


    models = {
        'Contacts.contactdata': {
            'Meta': {'object_name': 'ContactData'},
            'contact': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'data'", 'to': "orm['Contacts.Contacts']"}),
            'createdBy': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'createdDate': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'keyPair': ('django.db.models.fields.TextField', [], {}),
            'modifiedBy': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'modifiedDate': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
            'valuePair': ('django.db.models.fields.TextField', [], {})
        },
        'Contacts.contactlink': {
            'Meta': {'object_name': 'ContactLink'},
            'contact': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'links'", 'to': "orm['Contacts.Contacts']"}),
            'createdBy': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'createdDate': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
            'entity': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['Contacts.Entity']"}),
            'entityType': ('django.db.models.fields.TextField', [], {}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'modifiedBy': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'modifiedDate': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'})
        },
        'Contacts.contacts': {
            'Meta': {'object_name': 'Contacts'},
            'avator': ('django.db.models.fields.URLField', [], {'max_length': '200', 'blank': 'True'}),
            'createdBy': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'createdDate': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
            'description': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'modifiedBy': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'modifiedDate': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '255'})
        },
        'Contacts.contacttag': {
            'Meta': {'object_name': 'ContactTag'},
            'contact': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'tags'", 'to': "orm['Contacts.Contacts']"}),
            'createdBy': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'createdDate': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'modifiedBy': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'modifiedDate': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
            'tag': ('django.db.models.fields.CharField', [], {'max_length': '100'})
        },
        'Contacts.entity': {
            'Meta': {'object_name': 'Entity'},
            'createdBy': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'createdDate': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'modifiedBy': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'modifiedDate': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
            'name': ('django.db.models.fields.TextField', [], {})
        }
    }

    complete_apps = ['Contacts']