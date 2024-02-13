registry="kind-registry.local:5000"
version="1.5.3-nocompression"
tarball="rmq.$version.tar"

# echo "Downloading bundle as a tarball to: $tarball"
# imgpkg copy -b "registry.tanzu.vmware.com/p-rabbitmq-for-kubernetes/tanzu-rabbitmq-package-repo:$version" --to-tar $tarball

echo "Uploading bundle to: $registry"
imgpkg copy --tar "$tarball" --to-repo "$registry/p-rabbitmq-for-kubernetes/tanzu-rabbitmq-package-repo"