// This file is part of Desktop App Toolkit,
// a set of libraries for developing nice desktop applications.
//
// For license and copyright information please follow this link:
// https://github.com/desktop-app/legal/blob/master/LEGAL
//
#ifdef __FREEBSD__
#include <malloc_np.h>
#else // __FREEBSD__
#include <jemalloc/jemalloc.h>
#endif // !__FREEBSD__

namespace {

class JemallocInitializer {
public:
	JemallocInitializer() {
		auto backgroundThread = true;
		mallctl("background_thread", nullptr, nullptr, &backgroundThread, sizeof(bool));
	}
};

static const JemallocInitializer initializer;

} // namespace
