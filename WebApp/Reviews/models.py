from django.db import models

class URLqueue(models.Model):
    url = models.CharField(max_length=200)
    biz_name = models.CharField(db_index=True, max_length=40)
    biz_category = models.CharField(db_index=True, max_length=40)

    loc_city = models.CharField(db_index=True, max_length=40)
    loc_state = models.CharField(db_index=True, max_length=2)

    proc_date = models.DateTimeField(db_index=True, blank=True, null=True)
    proc_status = models.CharField(max_length=15, blank=True, null=True)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    class Meta:
        verbose_name = ("URLqueue")
        verbose_name_plural = ("URLqueues")

    def __unicode__(self):  # Python 3: def __str__(self):
        return self.url
